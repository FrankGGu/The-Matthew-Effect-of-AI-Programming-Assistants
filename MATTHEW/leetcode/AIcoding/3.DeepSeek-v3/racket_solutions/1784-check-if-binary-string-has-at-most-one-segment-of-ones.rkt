(define/contract (check-ones-segment s)
  (-> string? boolean?)
  (let loop ([i 0] [segments 0] [prev #\0])
    (cond
      [(= i (string-length s)) (<= segments 1)]
      [(and (char=? (string-ref s i) #\1) (char=? prev #\0))
       (loop (add1 i) (add1 segments) #\1)]
      [else (loop (add1 i) segments (string-ref s i))])))