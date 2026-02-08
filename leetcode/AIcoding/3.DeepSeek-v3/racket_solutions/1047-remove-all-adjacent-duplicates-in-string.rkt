(define/contract (remove-duplicates s)
  (-> string? string?)
  (let loop ([s s])
    (let ([changed? #f]
          [result (string)]
          [i 0]
          [n (string-length s)])
      (if (>= i n)
          (if changed? (loop result) result)
          (let ([c (string-ref s i)])
            (if (and (< i (- n 1)) (char=? c (string-ref s (+ i 1))))
                (begin
                  (set! changed? #t)
                  (loop (string-append result (substring s (+ i 2) n)) i (+ i 2)))
                (loop (string-append result (string c)) changed? result (+ i 1)))))))))