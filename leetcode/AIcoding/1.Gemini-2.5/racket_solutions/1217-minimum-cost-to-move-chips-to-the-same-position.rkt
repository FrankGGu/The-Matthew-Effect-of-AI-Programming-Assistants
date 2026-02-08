(define (min-cost-to-move-chips positions)
  (let loop ((pos-list positions)
             (even-count 0)
             (odd-count 0))
    (cond
      ((empty? pos-list)
       (min even-count odd-count))
      (else
       (let ((current-pos (car pos-list)))
         (if (even? current-pos)
             (loop (cdr pos-list) (+ even-count 1) odd-count)
             (loop (cdr pos-list) even-count (+ odd-count 1))))))))