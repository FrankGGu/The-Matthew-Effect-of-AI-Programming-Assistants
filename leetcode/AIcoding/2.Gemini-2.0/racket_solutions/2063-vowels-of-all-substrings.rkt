(define (count-vowels-in-substrings s)
  (define (vowel? c)
    (member c '(#\a #\e #\i #\o #\u)))

  (define n (string-length s))
  (define (helper i)
    (if (= i n)
        0
        (+ (if (vowel? (string-ref s i))
               (* (+ 1 i) (- n i))
               0)
           (helper (+ i 1)))))

  (helper 0))