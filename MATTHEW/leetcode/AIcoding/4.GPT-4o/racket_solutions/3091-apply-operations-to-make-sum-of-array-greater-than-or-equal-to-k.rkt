(define (min-operations nums k)
  (define (helper n ops)
    (if (>= (apply + nums) k)
        ops
        (if (null? n)
            (if (>= (apply + nums) k) ops +inf.0)
            (let ((x (car n)))
              (helper (cdr n) (+ ops 1 (if (< x 0) 0 x)))))))
  (helper (sort nums <) 0))