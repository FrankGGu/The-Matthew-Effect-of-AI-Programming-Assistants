(define (min-flips-mono-incr s)
  (define n (string-length s))
  (define (helper idx ones)
    (cond
      [(>= idx n) 0]
      [(char=? (string-ref s idx) #\0)
       (min (+ 1 ones) (helper (+ 1 idx) ones))]
      [else (min ones (helper (+ 1 idx) (+ 1 ones)))]))
  (helper 0 0))