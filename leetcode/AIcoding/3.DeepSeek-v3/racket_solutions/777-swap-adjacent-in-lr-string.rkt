(define (can-transform start end)
  (let loop ((i 0) (j 0) (n (string-length start)))
    (cond
      [(and (>= i n) (>= j n)) #t]
      [(or (>= i n) (>= j n)) #f]
      [(and (char=? (string-ref start i) #\X) (char=? (string-ref end j) #\X)) (loop (add1 i) (add1 j) n)]
      [(char=? (string-ref start i) #\X) (loop (add1 i) j n)]
      [(char=? (string-ref end j) #\X) (loop i (add1 j) n)]
      [(not (char=? (string-ref start i) (string-ref end j))) #f]
      [(and (char=? (string-ref start i) #\L) (< i j)) #f]
      [(and (char=? (string-ref start i) #\R) (> i j)) #f]
      [else (loop (add1 i) (add1 j) n)])))