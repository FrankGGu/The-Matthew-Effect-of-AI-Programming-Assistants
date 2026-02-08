(define (largest-merge word1 word2)
  (define (merge w1 w2 acc)
    (cond
      [(string=? w1 "") (string-append acc w2)]
      [(string=? w2 "") (string-append acc w1)]
      [(string>=? w1 w2) (merge (substring w1 1) w2 (string-append acc (substring w1 0 1)))]
      [else (merge w1 (substring w2 1) (string-append acc (substring w2 0 1)))]))
  (merge word1 word2 ""))