(define/contract (longest-continuous-substring s)
  (-> string? exact-integer?)
  (define n (string-length s))
  (if (= n 0)
      0
      (let loop ([i 1] [current 1] [max-len 1])
        (if (>= i n)
            max-len
            (let ([prev (char->integer (string-ref s (- i 1)))]
                  [curr (char->integer (string-ref s i))])
              (if (= curr (+ prev 1))
                  (let ([new-current (+ current 1)])
                    (loop (+ i 1) new-current (max max-len new-current)))
                  (loop (+ i 1) 1 (max max-len 1))))))))