(define (number-of-wonderful-substrings s)
  (define n (string-length s))
  (define (char->int c) (- (char->integer c) (char->integer #\a)))
  (define (calculate-wonderful-substrings)
    (let loop ([i 0] [count 0] [prefix-xor 0] [counts (dict #((0 . 1)))])
      (if (= i n)
          count
          (let* ([c (string-ref s i)]
                 [digit (char->int c)]
                 [new-prefix-xor (bitwise-xor prefix-xor (arithmetic-shift 1 digit))]
                 [new-count (+ count (dict-ref counts new-prefix-xor 0))])
            (let loop2 ([j 0])
              (if (= j 10)
                  (let ([new-counts (dict-set counts new-prefix-xor (+ 1 (dict-ref counts new-prefix-xor 0)))])
                    (loop (+ i 1) new-count new-prefix-xor new-counts))
                  (let ([xor-with-bit (bitwise-xor new-prefix-xor (arithmetic-shift 1 j))])
                    (loop2 (+ j 1) (set! new-count (+ new-count (dict-ref counts xor-with-bit 0)))))))))))
  (calculate-wonderful-substrings))