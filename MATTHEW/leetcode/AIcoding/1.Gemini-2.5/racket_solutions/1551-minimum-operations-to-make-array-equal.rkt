(define (min-operations n)
  (let* ((k (quotient n 2))
         (rem (remainder n 2)))
    (* k (+ k rem))))