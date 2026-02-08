(define (minimum-operations nums)
  (let loop ([nums (sort nums <)]
             [operations 0])
    (if (null? nums)
        operations
        (let ([min-val (car nums)])
          (if (zero? min-val)
              (loop (cdr nums) operations)
              (loop (map (lambda (x) (- x min-val)) (cdr nums)) 
                    (+ operations 1)))))))