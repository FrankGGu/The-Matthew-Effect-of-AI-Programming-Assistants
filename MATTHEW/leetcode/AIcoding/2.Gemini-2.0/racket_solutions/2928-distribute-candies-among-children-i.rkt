(define (distribute-candies n limit)
  (let loop ([i 0] [count 0])
    (cond
      [(> i limit) count]
      [else (let loop2 ([j 0])
              (cond
                [(> j limit) (loop (+ i 1) count)]
                [else (let ([k (- n i j)])
                        (if (and (>= k 0) (<= k limit))
                            (loop (+ i 1) (+ count 1))
                            (loop2 (+ j 1))))]))]))
  0)