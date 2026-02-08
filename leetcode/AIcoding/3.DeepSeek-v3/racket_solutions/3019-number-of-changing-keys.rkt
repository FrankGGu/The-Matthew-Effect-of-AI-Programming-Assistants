(define/contract (count-key_changes s)
  (-> string? exact-integer?)
  (let loop ([i 1] [count 0])
    (if (>= i (string-length s))
        count
        (let ([prev (char-downcase (string-ref s (- i 1)))]
              [curr (char-downcase (string-ref s i))])
          (loop (+ i 1) (if (char=? prev curr) count (+ count 1)))))))