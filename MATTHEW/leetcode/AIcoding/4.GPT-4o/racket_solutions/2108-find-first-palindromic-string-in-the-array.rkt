(define (is-palindrome str)
  (equal? str (string-reverse str)))

(define (first-palindrome arr)
  (for/fold ([result #f]) ([s arr])
    (if (and (not result) (is-palindrome s))
        s
        result)))

(first-palindrome '("abc" "car" "ada" "racecar"))