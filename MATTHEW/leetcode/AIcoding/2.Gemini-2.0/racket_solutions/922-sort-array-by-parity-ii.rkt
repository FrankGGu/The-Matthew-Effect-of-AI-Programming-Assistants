(define (sort-array-by-parity-ii A)
  (let ([n (length A)])
    (let loop ([i 0] [j 1] [result A])
      (cond
        [(>= i n) result]
        [(even? (list-ref result i)) (loop (+ i 2) j result)]
        [else
         (cond
           [(odd? (list-ref result j)) (loop i (+ j 2) result)]
           [else
            (let ([temp (list-ref result i)])
              (let ([new-result (list-set result i (list-ref result j))])
                (loop (+ i 2) (+ j 2) (list-set new-result j temp))))])]))))