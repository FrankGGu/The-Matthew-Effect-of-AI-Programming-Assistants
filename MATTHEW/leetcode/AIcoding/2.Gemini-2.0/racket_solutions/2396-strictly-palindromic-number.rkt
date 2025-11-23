(define (base->digits n base)
  (if (= n 0)
      '(0)
      (let loop ((n n) (digits '()))
        (if (= n 0)
            (reverse digits)
            (loop (quotient n base) (cons (remainder n base) digits))))))

(define (is-palindrome? lst)
  (equal? lst (reverse lst)))

(define (is-strictly-palindromic n)
  (cond
    [(<= n 3) #f]
    [else
     (let loop ((base 2))
       (cond
         [(>= base (- n 1)) #t]
         [(not (is-palindrome? (base->digits n base))) #f]
         [else (loop (+ base 1))]))]))