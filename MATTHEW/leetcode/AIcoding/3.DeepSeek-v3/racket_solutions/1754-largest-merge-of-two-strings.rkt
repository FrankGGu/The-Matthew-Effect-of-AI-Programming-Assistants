(define (largest-merge word1 word2)
  (let loop ([w1 word1] [w2 word2] [result ""])
    (cond
      [(string=? w1 "") (string-append result w2)]
      [(string=? w2 "") (string-append result w1)]
      [else
       (if (string>? (substring w1 0) (substring w2 0))
           (loop (substring w1 1) w2 (string-append result (substring w1 0 1)))
           (loop w1 (substring w2 1) (string-append result (substring w2 0 1))))])))