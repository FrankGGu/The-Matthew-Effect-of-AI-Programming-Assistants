#lang racket

(define (can-complete-circuit gas cost)
  (let* ((n (length gas))
         (gas-vec (list->vector gas))
         (cost-vec (list->vector cost))
         (result
          (for/fold ((total-tank 0)
                     (current-tank 0)
                     (start-node 0))
                    ((i (in-range n)))
            (let* ((g (vector-ref gas-vec i))
                   (c (vector-ref cost-vec i))
                   (diff (- g c)))
              (let ((new-total-tank (+ total-tank diff))
                    (new-current-tank (+ current-tank diff)))
                (if (< new-current-tank 0)
                    (values new-total-tank 0 (+ i 1))
                    (values new-total-tank new-current-tank start-node)))))))
    (let ((final-total-tank (car result))
          (final-start-node (caddr result)))
      (if (< final-total-tank 0)
          -1
          final-start-node))))