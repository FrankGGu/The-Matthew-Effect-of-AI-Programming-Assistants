(define (count-segments s)
  (let loop ([i 0] [count 0] [in-segment? #f])
    (cond
      [(= i (string-length s)) count]
      [(char-whitespace? (string-ref s i))
       (loop (add1 i) count #f)]
      [else
       (if in-segment?
           (loop (add1 i) count #t)
           (loop (add1 i) (add1 count) #t))])))