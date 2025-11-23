(define/contract (count-vowel-substrings word k)
  (-> string? exact-integer? exact-integer?)
  (define vowels (set #\a #\e #\i #\o #\u))
  (define n (string-length word))
  (let loop ([i 0] [res 0])
    (if (>= i n)
        res
        (if (set-member? vowels (string-ref word i))
            (let ([vowel-count (make-hash)]
                  [consonant-count 0]
                  [j i])
              (hash-set! vowel-count (string-ref word i) 1)
              (let inner-loop ([j (add1 j)])
                (if (>= j n)
                    (loop (add1 i) res)
                    (let ([c (string-ref word j)])
                      (if (set-member? vowels c)
                          (begin
                            (hash-set! vowel-count c (add1 (hash-ref vowel-count c 0)))
                            (if (and (= (hash-count vowel-count) 5) (= consonant-count k))
                                (inner-loop (add1 j) (add1 res))
                                (inner-loop (add1 j) res)))
                          (begin
                            (set! consonant-count (add1 consonant-count))
                            (if (> consonant-count k)
                                (loop (add1 i) res)
                                (inner-loop (add1 j) res)))))))))
            (loop (add1 i) res)))))