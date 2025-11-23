(define/contract (can-change start target)
  (-> string? string? boolean?)
  (let loop ([i 0] [j 0] [n (string-length start)] [m (string-length target)])
    (cond
      [(and (>= i n) (>= j m)) #t]
      [(or (>= i n) (>= j m)) #f]
      [(char=? (string-ref start i) #\_)
       (loop (add1 i) j n m)]
      [(char=? (string-ref target j) #\_)
       (loop i (add1 j) n m)]
      [(not (char=? (string-ref start i) (string-ref target j))) #f]
      [(and (char=? (string-ref start i) #\L) (< i j)) #f]
      [(and (char=? (string-ref start i) #\R) (> i j)) #f]
      [else (loop (add1 i) (add1 j) n m)])))