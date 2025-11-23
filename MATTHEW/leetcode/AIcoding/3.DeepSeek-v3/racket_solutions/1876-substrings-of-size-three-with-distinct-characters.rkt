(define/contract (count-good-substrings s)
  (-> string? exact-integer?)
  (define n (string-length s))
  (if (< n 3)
      0
      (let loop ([i 0] [count 0])
        (if (> (+ i 2) (- n 1))
            count
            (let ([a (string-ref s i)]
                  [b (string-ref s (+ i 1))]
                  [c (string-ref s (+ i 2))])
              (if (and (not (eqv? a b)) (not (eqv? a c)) (not (eqv? b c)))
                  (loop (+ i 1) (+ count 1))
                  (loop (+ i 1) count)))))))