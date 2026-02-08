#lang racket

(define (next-greater-nodes head)
  ;; Step 1: Convert linked list to a Racket list of values
  (let loop-list ((node head) (acc '()))
    (if (null? node)
        (let* ((vals (reverse acc)) ; Get values in correct order
               (n (length vals))
               (vals-vec (list->vector vals)) ; Convert to vector for O(1) access
               (result-vec (make-vector n 0)) ; Initialize result vector with zeros
               (stack '())) ; Stack to store indices (list of integers)

          ;; Step 2: Iterate through the values using a monotonic stack
          (for ([i (in-range n)])
            (let ((current-val (vector-ref vals-vec i)))
              ;; Pop elements from stack whose values are less than current-val
              (let loop-pop ((current-stack stack))
                (if (and (not (empty? current-stack))
                         (< (vector-ref vals-vec (car current-stack)) current-val))
                    (begin
                      (vector-set! result-vec (car current-stack) current-val)
                      (loop-pop (cdr current-stack)))
                    ;; When loop-pop finishes, current-stack holds the updated stack
                    ;; Push current index onto this updated stack
                    (set! stack (cons i current-stack))))))

          ;; Step 3: Return the result vector
          result-vec)
        (loop-list (ListNode-next node) (cons (ListNode-val node) acc)))))