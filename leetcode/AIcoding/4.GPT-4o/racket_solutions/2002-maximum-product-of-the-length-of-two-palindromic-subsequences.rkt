(define (maxProduct palindromes)
  (define (is-palindrome? s)
    (equal? s (string-reverse s)))

  (define (palindrome-subsequences s)
    (let loop ((n (string-length s)) (subsequences '()))
      (if (= n 0)
          subsequences
          (loop (- n 1) (cons (substring s 0 n) subsequences)))))

  (define palindromic-subs (filter is-palindrome? (palindrome-subsequences palindromes)))

  (define (lengths lst)
    (map string-length lst))

  (define palin-lens (lengths palindromic-subs))

  (define max-prod 0)
  (for ((i (in-range (length palin-lens))))
    (for ((j (in-range (add1 i) (length palin-lens))))
      (set! max-prod (max max-prod (* (list-ref palin-lens i) (list-ref palin-lens j))))))

  max-prod)

(define (maxProductOfPalindromicSubsequences s)
  (maxProduct s))