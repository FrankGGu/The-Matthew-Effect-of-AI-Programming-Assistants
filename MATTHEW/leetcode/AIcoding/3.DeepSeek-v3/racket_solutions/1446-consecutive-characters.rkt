(define/contract (max-power s)
  (-> string? exact-integer?)
  (let loop ([i 1] [current-char (string-ref s 0)] [current-count 1] [max-count 1])
    (cond
      [(= i (string-length s)) max-count]
      [(char=? (string-ref s i) current-char)
       (let ([new-count (+ current-count 1)])
         (loop (+ i 1) current-char new-count (max max-count new-count)))]
      [else
       (loop (+ i 1) (string-ref s i) 1 max-count)])))