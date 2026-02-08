(define (sum-nums n)
  (let ((total 0))
    (letrec ((accumulate (lambda (k)
                           (and (> k 0)
                                (begin
                                  (set! total (+ total k))
                                  (accumulate (- k 1)))))))
      (accumulate n)
      total)))