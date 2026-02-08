(define (my-pow x n)
  (let* ((base (if (< n 0) (/ 1.0 x) x))
         (exp (if (< n 0) (- n) n)))
    (let loop ((b base) (e exp) (res 1.0))
      (cond
        [(= e 0) res]
        [(odd? e) (loop (* b b) (quotient e 2) (* res b))]
        [else (loop (* b b) (quotient e 2) res)]))))