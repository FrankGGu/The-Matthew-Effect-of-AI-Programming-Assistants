(define/contract (minimum-cost s)
  (-> string? exact-integer?)
  (let ([n (string-length s)])
    (if (<= n 1)
        0
        (let loop ([i 1] [cost 0])
          (if (>= i n)
              cost
              (if (char=? (string-ref s (- i 1)) (string-ref s i))
                  (loop (+ i 1) cost)
                  (loop (+ i 1) (+ cost (min i (- n i)))))))))