(define (longestPalindrome s)
  (define (is-palindrome str)
    (equal? str (list->string (reverse (string->list str)))))

  (define (max-palindrome len)
    (for/fold ([max-pal ""]) ([i (in-range (string-length s))])
      (for/fold ([current-pal ""]) ([j (in-range (string-length s))])
        (let ([substr (substring s i (+ i j))])
          (if (and (<= (string-length substr) len) (is-palindrome substr))
              (if (> (string-length substr) (string-length current-pal))
                  substr
                  current-pal)
              current-pal))))
    (for/fold ([final-pal ""]) ([pal (in-list (list->vector (for/list ([i (in-range (string-length s))])
                                                               (max-palindrome i))))])
      (if (> (string-length pal) (string-length final-pal))
          pal
          final-pal)))

  (max-palindrome (string-length s)))