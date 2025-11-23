(define (merge-alternately word1 word2)
  (let loop ([i 0] [j 0] [result ""])
    (cond
      [(and (= i (string-length word1)) (= j (string-length word2))) result]
      [(< i (string-length word1)) (loop (+ i 1) j (string-append result (substring word1 i (+ i 1))))]
      [(< j (string-length word2)) (loop i (+ j 1) (string-append result (substring word2 j (+ j 1))))]
      [else result])))