(define/contract (min-operations s)
  (-> string? exact-integer?)
  (let loop ([i 0] [count1 0] [count2 0])
    (if (>= i (string-length s))
        (min count1 count2)
        (let ([c (string-ref s i)]
              [expected1 (if (even? i) #\0 #\1)]
              [expected2 (if (even? i) #\1 #\0)])
          (loop (+ i 1)
                (if (char=? c expected1) count1 (+ count1 1))
                (if (char=? c expected2) count2 (+ count2 1)))))))