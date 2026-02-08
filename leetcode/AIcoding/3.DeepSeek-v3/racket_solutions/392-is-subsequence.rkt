(define/contract (is-subsequence s t)
  (-> string? string? boolean?)
  (let loop ([i 0] [j 0])
    (cond
      [(= i (string-length s)) #t]
      [(= j (string-length t)) #f]
      [(char=? (string-ref s i) (string-ref t j)) (loop (+ i 1) (+ j 1))]
      [else (loop i (+ j 1))])))