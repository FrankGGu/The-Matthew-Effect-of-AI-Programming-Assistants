(define/contract (append-characters s t)
  (-> string? string? exact-integer?)
  (let loop ((i 0) (j 0))
    (cond
      [(= j (string-length t)) 0]
      [(= i (string-length s)) (- (string-length t) j)]
      [(char=? (string-ref s i) (string-ref t j)) (loop (+ i 1) (+ j 1))]
      [else (loop (+ i 1) j)])))