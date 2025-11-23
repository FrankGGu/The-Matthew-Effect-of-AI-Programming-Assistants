(define (make-neighbor-sum-service n)
  (let ([grid (make-vector (* n n) 0)]
        [size n])
    (define (get-index row col)
      (+ (* row size) col))
    (define (set-val row col val)
      (vector-set! grid (get-index row col) val))
    (define (get-val row col)
      (vector-ref grid (get-index row col)))
    (define (query row col)
      (let ([sum 0])
        (for ([dr '(-1 -1 -1 0 0 1 1 1)]
              [dc '(-1 0 1 -1 1 -1 0 1)])
          (let ([new-row (+ row dr)]
                [new-col (+ col dc)])
            (when (and (>= new-row 0) (< new-row size) (>= new-col 0) (< new-col size))
              (set! sum (+ sum (get-val new-row new-col))))))
        sum))
    (struct neighbor-sum-service (set-val query))
    (neighbor-sum-service set-val query)))

(define (neighbor-sum-service-set-val nss row col val)
  ((neighbor-sum-service-set-val nss) row col val))

(define (neighbor-sum-service-query nss row col)
  ((neighbor-sum-service-query nss) row col))