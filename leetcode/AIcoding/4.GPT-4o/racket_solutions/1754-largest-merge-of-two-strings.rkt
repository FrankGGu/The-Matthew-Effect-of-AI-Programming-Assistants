(define (largestMerge word1 word2)
  (define (merge w1 w2)
    (cond
      [(empty? w1) w2]
      [(empty? w2) w1]
      [(string>? w1 w2) (string-append (string (first w1)) (merge (rest w1) w2))]
      [else (string-append (string (first w2)) (merge w1 (rest w2)))]))
  (merge (string->list word1) (string->list word2)))