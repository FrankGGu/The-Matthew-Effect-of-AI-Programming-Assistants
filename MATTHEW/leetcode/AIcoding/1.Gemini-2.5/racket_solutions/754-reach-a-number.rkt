(define (reach-number target)
  (let ((t (abs target)))
    (let loop ((n 0) (sum-steps 0))
      (if (and (>= sum-steps t)
               (even? (- sum-steps t)))
          n
          (loop (+ n 1) (+ sum-steps (+ n 1)))))))