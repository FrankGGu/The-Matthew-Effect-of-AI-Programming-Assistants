(define (longest-palindrome after-substring-concatenation I s)
  (define (is-palindrome? str)
    (equal? str (string-reverse str)))

  (define (find-longest-palindrome str)
    (let loop ([i 0] [max-len 0] [max-str ""])
      (if (= i (string-length str))
          max-len
          (let loop2 ([j i])
            (if (= j (string-length str))
                (loop (+ i 1) max-len max-str)
                (let ([sub (substring str i (+ j 1))])
                  (if (and (is-palindrome? sub) (> (string-length sub) max-len))
                      (loop (+ i 1) (string-length sub) sub)
                      (loop2 (+ j 1)))))))))

  (find-longest-palindrome s))