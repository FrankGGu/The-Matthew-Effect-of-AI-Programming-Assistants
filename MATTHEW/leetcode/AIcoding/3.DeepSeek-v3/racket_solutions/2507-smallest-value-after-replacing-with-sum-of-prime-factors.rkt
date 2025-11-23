(define (smallest-value n)
  (define (sum-prime-factors x)
    (let loop ([x x] [sum 0] [divisor 2])
      (cond
        [(= x 1) sum]
        [(zero? (remainder x divisor))
         (loop (/ x divisor) (+ sum divisor) divisor]
        [else (loop x sum (+ divisor 1))])))
  (let loop ([current n] [prev 0])
    (if (= current prev)
        current
        (loop (sum-prime-factors current) current))))