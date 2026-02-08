(define (findTheLongestBalancedSubstring s)
  (define n (string-length s))
  (define max-len 0)
  (define (helper i j)
    (cond
      [(or (< i 0) (>= j n)) 0]
      [(and (char=? (string-ref s i) #\0) (char=? (string-ref s j) #\1))
       (set! max-len (max max-len (- j i -1)))
       (helper (sub1 i) (add1 j))]
      [else 0]))
  (for ([i (in-range n)])
    (helper i (add1 i)))
  max-len)