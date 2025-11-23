(define/contract (interpret command)
  (-> string? string?)
  (let loop ([i 0] [res ""])
    (cond
      [(>= i (string-length command)) res]
      [(char=? (string-ref command i) #\G)
       (loop (add1 i) (string-append res "G"))]
      [(and (< (add1 i) (string-length command))
       (if (char=? (string-ref command (add1 i)) #\))
           (loop (+ i 2) (string-append res "o"))
           (loop (+ i 4) (string-append res "al")))]
      [else res])))