(define (is-strictly-palindromic n)
  (define (int->list-base n base)
    (if (= n 0)
        '()
        (let loop ((num n) (acc '()))
          (if (= num 0)
              acc
              (loop (quotient num base) (cons (remainder num base) acc))))))

  (define (palindrome? lst)
    (equal? lst (reverse lst)))

  (let loop ((b 2))
    (if (>= b (- n 1))
        #t
        (if (palindrome? (int->list-base n b))
            (loop (+ b 1))
            #f))))