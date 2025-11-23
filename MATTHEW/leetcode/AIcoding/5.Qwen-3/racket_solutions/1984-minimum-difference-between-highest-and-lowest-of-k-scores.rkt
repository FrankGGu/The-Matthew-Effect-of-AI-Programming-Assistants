(define (minimum-difference nums k)
  (if (= k 1) 0
      (let ((sorted (sort nums <)))
        (let loop ((i 0) (min-diff +inf.0))
          (if (>= i (- (length sorted) k)) min-diff
              (loop (+ i 1) (min (- (list-ref sorted (+ i (- k 1))) (list-ref sorted i)) min-diff)))))))