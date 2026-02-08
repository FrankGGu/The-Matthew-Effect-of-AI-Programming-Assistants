(define (longest-palindrome-decomposition s)
  (define (is-palindrome str)
    (equal? str (string-reverse str)))

  (define (helper start end)
    (if (>= start end)
        0
        (for/fold ([max-chunks 0]) ([i (in-range start end)])
          (if (is-palindrome (substring s start (+ i 1)))
              (max max-chunks (+ 1 (helper (+ i 1) end)))
              max-chunks))))

  (helper 0 (string-length s)))

(longest-palindrome-decomposition "ghiabcdefhellohiabcdefghi")