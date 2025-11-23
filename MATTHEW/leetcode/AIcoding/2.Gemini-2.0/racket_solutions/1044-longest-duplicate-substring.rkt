(define (longest-duplicate-substring s)
  (define n (string-length s))
  (define (search len)
    (define seen (make-hash))
    (for ([i (range (- n len) 0 -1)])
      (define sub (substring s i (+ i len)))
      (when (hash-has-key? seen sub)
        (return sub))
      (hash-set! seen sub #t))
    #f)
  (define (binary-search low high)
    (cond
      [(> low high) #f]
      [else
       (define mid (quotient (+ low high) 2))
       (define result (search mid))
       (cond
         [(not result)
          (binary-search low (- mid 1))]
         [else
          (define next-result (binary-search (+ mid 1) high))
          (if next-result next-result result)])]))
  (or (binary-search 1 (- n 1)) ""))