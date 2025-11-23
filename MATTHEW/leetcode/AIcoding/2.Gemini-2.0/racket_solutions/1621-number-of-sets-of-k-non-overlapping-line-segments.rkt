(define (number-of-sets n k)
  (define memo (make-hash))

  (define (dp i j)
    (cond
      [(< i 0) 0]
      [(< j 0) 0]
      [(= j 0) 1]
      [(hash-has-key? memo (cons i j)) (hash-ref memo (cons i j))]
      [else
       (let ([res (modulo (+ (dp (- i 1) j)
                               (modulo (* (- i 1) (dp (- i 2) (- j 1))) 1000000007))
                            1000000007)])
         (hash-set! memo (cons i j) res)
         res)]))

  (dp (- n 1) k))