(define (maximum-operations nums)
  (define (helper nums ones zeros operations)
    (cond
      [(empty? nums) operations]
      [else
       (let ([first (first nums)]
              [rest (rest nums)])
         (cond
           [(= first 1) (helper rest (add1 ones) zeros operations)]
           [(= first 0)
            (cond
              [(> ones 0) (helper rest (sub1 ones) (add1 zeros) (add1 operations))]
              [else (helper rest ones (add1 zeros) operations)])]
           [else (error "Invalid input: numbers must be 0 or 1")]))]))
  (helper nums 0 0 0))