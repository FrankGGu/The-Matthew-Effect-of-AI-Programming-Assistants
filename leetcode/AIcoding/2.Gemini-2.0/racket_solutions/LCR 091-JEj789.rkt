(define (min-cost costs)
  (let ([n (length costs)])
    (if (zero? n)
        0
        (let loop ([i 1] [dp (list-ref costs 0)])
          (if (= i n)
              (apply min dp)
              (let ([new-dp (list
                              (+ (list-ref costs i 0) (min (list-ref dp 1) (list-ref dp 2)))
                              (+ (list-ref costs i 1) (min (list-ref dp 0) (list-ref dp 2)))
                              (+ (list-ref costs i 2) (min (list-ref dp 0) (list-ref dp 1))))])
                (loop (+ i 1) new-dp)))))))