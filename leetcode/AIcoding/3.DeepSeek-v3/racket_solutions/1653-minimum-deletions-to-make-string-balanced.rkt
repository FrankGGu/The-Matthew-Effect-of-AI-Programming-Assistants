(define/contract (minimum-deletions s)
  (-> string? exact-integer?)
  (let loop ([i 0] [a-count 0] [b-count 0] [min-del 0])
    (if (= i (string-length s))
        min-del
        (let ([c (string-ref s i)])
          (if (char=? c #\a)
              (loop (add1 i) (add1 a-count) b-count (min min-del b-count))
              (loop (add1 i) a-count (add1 b-count) (min min-del (add1 b-count)))))))