(define/contract (merge-alternately word1 word2)
  (-> string? string? string?)
  (let loop ([i 0] [result ""])
    (cond
      [(and (< i (string-length word1)) (< i (string-length word2)))
       (loop (+ i 1) (string-append result (string (string-ref word1 i)) (string (string-ref word2 i))))]
      [(< i (string-length word1))
       (string-append result (substring word1 i))]
      [(< i (string-length word2))
       (string-append result (substring word2 i))]
      [else result])))