(define (is-palindrome? s)
  (equal? s (string-reverse s)))

(define (superpalindromesInRange left right)
  (define (int->string n)
    (number->string n))

  (define (string->int s)
    (string->number s))

  (define (generate-palindromes len)
    (cond
      [(= len 1) (map int->string '(1 2 3 4 5 6 7 8 9))]
      [(= len 2) (map int->string '(11 22 33 44 55 66 77 88 99))]
      [else
       (define (generate-half n)
         (cond
           [(= n 1) (map int->string '(1 2 3 4 5 6 7 8 9))]
           [else
            (for*/list ([prefix (generate-half (- n 1))]
                        [digit (map int->string '(0 1 2 3 4 5 6 7 8 9))])
              (string-append prefix digit))]))
       (define half-len (quotient len 2))
       (define half-palindromes (generate-half half-len))
       (map (lambda (half)
              (string-append half (string-reverse half)))
            half-palindromes)]))

  (define (generate-odd-palindromes len)
    (define (generate-half n)
      (cond
        [(= n 0) (map int->string '(0 1 2 3 4 5 6 7 8 9))]
        [else
         (for*/list ([prefix (generate-half (- n 1))]
                     [digit (map int->string '(0 1 2 3 4 5 6 7 8 9))])
           (string-append prefix digit))]))

    (define half-len (quotient len 2))
    (define half-palindromes (generate-half half-len))
    (for*/list ([half half-palindromes]
                [middle (map int->string '(0 1 2 3 4 5 6 7 8 9))])
      (string-append half middle (string-reverse half))))

  (define (generate-palindromes-up-to-len max-len)
    (append
     (apply append (map generate-palindromes (range 1 (+ 1 max-len 2))))
     (apply append (map generate-odd-palindromes (range 1 (+ 1 max-len 2))))))

  (define max-root (floor (sqrt (string->int right))))
  (define max-len (integer-length max-root))

  (define palindromes (filter (lambda (s)
                               (let ([n (string->int s)])
                                 (and (<= (string->int left) (* n n))
                                      (<= (* n n) (string->int right)))))
                             (remove-duplicates
                              (append (generate-palindromes-up-to-len max-len) (list "0"))
                              equal?)))

  (length
   (filter (lambda (s)
             (let ([n (string->int s)])
               (and (<= (string->int left) (* n n))
                    (<= (* n n) (string->int right))
                    (is-palindrome? (int->string (* n n))))))
           (remove-duplicates
            (map int->string
                 (filter (lambda (x)
                           (and (<= (string->int left) (* x x))
                                (<= (* x x) (string->int right))))
                         (range 0 (+ 1 (floor (sqrt (string->int right))))))) equal?))))