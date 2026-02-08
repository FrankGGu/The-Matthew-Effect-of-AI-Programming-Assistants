(define (binary-gap n)
  (let loop ([n n] [last-one #f] [max-gap 0] [current-gap 0])
    (cond
      [(zero? n) max-gap]
      [(= (remainder n 2) 1)
       (if last-one
           (loop (quotient n 2) #t (max max-gap current-gap) 1)
           (loop (quotient n 2) #t max-gap 1))]
      [else
       (if last-one
           (loop (quotient n 2) #t max-gap (+ current-gap 1))
           (loop (quotient n 2) last-one max-gap 0))
       ])))