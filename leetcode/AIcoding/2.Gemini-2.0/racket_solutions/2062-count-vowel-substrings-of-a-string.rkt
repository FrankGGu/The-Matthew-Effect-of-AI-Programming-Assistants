(define (count-vowel-substrings word)
  (define (vowel? c)
    (member c '(#\a #\e #\i #\o #\u)))

  (define (all-vowels? sub)
    (and (string-contains? sub "a")
         (string-contains? sub "e")
         (string-contains? sub "i")
         (string-contains? sub "o")
         (string-contains? sub "u")
         (for/and ([c (in-string sub)])
           (vowel? c))))

  (define n (string-length word))
  (let loop ([i 0] [count 0])
    (if (= i n)
        count
        (let inner-loop ([j i])
          (if (= j n)
              count
              (let ([sub (substring word i (+ j 1))])
                (inner-loop (+ j 1) (if (all-vowels? sub) (+ count 1) count)))))))

  (loop 0 0))