(define (sum-of-good-numbers n)
  (let loop ((i 1) (sum 0))
    (cond
      [(> i n) sum]
      [(and (zero? (modulo i 3))
            (not (zero? (modulo i 5))))
       (loop (+ i 1) (+ sum i))]
      [(and (zero? (modulo i 5))
            (not (zero? (modulo i 3))))
       (loop (+ i 1) (+ sum i))]
      [else (loop (+ i 1) sum)])))