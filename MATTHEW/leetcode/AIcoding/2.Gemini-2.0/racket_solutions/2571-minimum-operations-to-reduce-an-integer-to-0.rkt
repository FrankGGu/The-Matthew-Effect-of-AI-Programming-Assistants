(define (minimum-operations n)
  (let loop ([n n] [ops 0])
    (cond
      [(zero? n) ops]
      [(= (remainder n 2) 0) (loop (quotient n 2) ops)]
      [(= (remainder n 4) 1) (loop (- n 1) (+ ops 1))]
      [else (loop (+ n 1) (+ ops 1))])))