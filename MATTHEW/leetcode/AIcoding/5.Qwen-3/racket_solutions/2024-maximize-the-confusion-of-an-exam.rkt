(define (max-letters s c)
  (let loop ([i 0] [j 0] [count 0] [max-count 0])
    (cond [(= j (string-length s)) max-count]
          [(char=? (string-ref s j) c)
           (loop i (add1 j) (add1 count) (max max-count count))]
          [else
           (loop (add1 i) (add1 j) (- count 1) max-count)])))

(define (max-confusion s)
  (max (max-letters s #\T) (max-letters s #\F)))