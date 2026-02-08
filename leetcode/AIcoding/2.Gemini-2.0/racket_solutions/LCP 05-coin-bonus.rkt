(define (coin-bonus n queries)
  (define fenwick (make-vector (+ n 1) 0))

  (define (update idx val)
    (let loop ([i (+ idx 1)])
      (when (<= i n)
        (vector-set! fenwick i (+ (vector-ref fenwick i) val))
        (loop (+ i (bitwise-and (- i) i))))))

  (define (query idx)
    (let loop ([i (+ idx 1)] [sum 0])
      (if (> i 0)
          (loop (- i (bitwise-and (- i) i)) (+ sum (vector-ref fenwick i)))
          sum)))

  (define (range-sum l r)
    (- (query r) (query (- l 1))))

  (for ([q queries])
    (match q
      [(list 0 l r val) (for ([i l (add1 r)]) (update i val))]
      [(list 1 l r) (displayln (range-sum l r))]))

  (void))