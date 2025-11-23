(define (minimum-difference nums k)
  (let* ([sorted-nums (sort nums <)]
         [n (length sorted-nums)])
    (let loop ([i 0]
               [min-diff (inexact-real-max)])
      (if (>= i (- n k -1))
          min-diff
          (loop (+ i 1) (min min-diff (- (list-ref sorted-nums (+ i k -1)) (list-ref sorted-nums i))))))))