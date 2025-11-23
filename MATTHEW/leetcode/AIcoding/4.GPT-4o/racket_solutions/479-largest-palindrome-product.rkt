(define (largest-palindrome-product n)
  (define (is-palindrome x)
    (let ([s (number->string x)])
      (equal? s (string-reverse s))))

  (define (largest-palindrome)
    (for/fold ([max-palindrome 0]) ([i (in-range (expt 10 n) (expt 10 (- n 1)) -1)])
      (for/fold ([j (in-range (expt 10 n) (expt 10 (- n 1)) -1)])
        ([p (* i j)])
        (if (and (> p max-palindrome) (is-palindrome p))
            p
            max-palindrome))))

  (largest-palindrome))