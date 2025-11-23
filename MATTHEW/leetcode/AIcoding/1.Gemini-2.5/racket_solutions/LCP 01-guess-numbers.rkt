(define (guess-number n)
  (define (binary-search low high)
    (if (<= low high)
        (let* ([mid (+ low (quotient (- high low) 2))]
               [res (guess mid)])
          (cond
            [(= res 0) mid]
            [(= res -1) (binary-search low (- mid 1))]
            [(= res 1) (binary-search (+ mid 1) high)]))
        -1)) ; Should not be reached if a number is guaranteed to be found
  (binary-search 1 n))