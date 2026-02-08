(define (vowels-game s)
  (define n (string-length s))
  (define (vowel? c)
    (case c
      [(#\a) #t]
      [(#\e) #t]
      [(#\i) #t]
      [(#\o) #t]
      [(#\u) #t]
      [else #f]))
  (define (solve s)
    (define n (string-length s))
    (define alice 0)
    (define bob 0)
    (for ([i (in-range n)])
      (when (vowel? (string-ref s i))
        (let ([val (* (+ 1 i) (- n i))])
          (if (even? n)
              (set! bob (+ bob val))
              (set! alice (+ alice val))))))
    (cond
      [(> alice bob) "Alice"]
      [(< alice bob) "Bob"]
      [else "draw"]))
  (solve s))