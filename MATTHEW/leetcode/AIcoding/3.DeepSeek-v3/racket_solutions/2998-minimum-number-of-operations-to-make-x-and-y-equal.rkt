(define (minimum-operations x y)
  (define (helper x y visited)
    (cond
      [(= x y) 0]
      [(> x y) (- x y)]
      [(hash-has-key? visited x) (hash-ref visited x)]
      [(even? y) (let ([res (helper x (/ y 2) (hash-set visited x (helper x (/ y 2) visited)))])
                  (hash-set! visited x res)
                  res)]
      [else (let ([res (add1 (min (helper x (add1 y) visited)
                                  (helper x (sub1 y) visited)))])
              (hash-set! visited x res)
              res)]))
  (helper x y (make-hash)))