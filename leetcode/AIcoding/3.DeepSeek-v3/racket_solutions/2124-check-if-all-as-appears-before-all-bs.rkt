(define/contract (check-string s)
  (-> string? boolean?)
  (let loop ([i 0] [seen-b #f])
    (cond
      [(= i (string-length s)) #t]
      [(char=? (string-ref s i) #\a)
       (if seen-b #f (loop (add1 i) #f))]
      [else (loop (add1 i) #t)])))