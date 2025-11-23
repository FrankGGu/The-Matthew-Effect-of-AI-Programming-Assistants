(define (search-matrix matrix target)
  (let* ((m (length matrix))
         (n (length (car matrix))))
    (let loop ((low 0) (high (- (* m n) 1)))
      (cond
        ((> low high) #f)
        (else
         (let* ((mid (+ low (quotient (- high low) 2)))
                (row (quotient mid n))
                (col (remainder mid n))
                (val (list-ref (list-ref matrix row) col)))
           (cond
             ((= val target) #t)
             ((< val target) (loop (+ mid 1) high))
             (else (loop low (- mid 1))))))))))