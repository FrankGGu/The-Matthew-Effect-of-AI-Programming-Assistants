(define/contract (is-long-pressed-name name typed)
  (-> string? string? boolean?)
  (let loop ([i 0] [j 0] [n (string-length name)] [m (string-length typed)])
    (cond
      [(and (= i n) (= j m)) #t]
      [(or (>= i n) (>= j m)) #f]
      [(char=? (string-ref name i) (string-ref typed j)) (loop (add1 i) (add1 j) n m)]
      [(and (> i 0) (char=? (string-ref name (sub1 i)) (string-ref typed j))) (loop i (add1 j) n m)]
      [else #f])))