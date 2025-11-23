(define (smallest-substring s)
  (let ([n (string-length s)])
    (if (<= n 1)
        n
        (let loop ([i 0] [min-len n])
          (if (= i n)
              min-len
              (let ([c (string-ref s i)])
                (let loop2 ([j (+ i 1)])
                  (cond
                    [(= j n) min-len]
                    [(char=? c (string-ref s j))
                     (loop (+ j 1) (min min-len (+ j 1 (- i))))]
                    [else (loop2 (+ j 1))]))))))))