(define/contract (prime-palindrome n)
  (-> exact-integer? exact-integer?)
  (define (palindrome? x)
    (let ([s (number->string x)])
      (equal? s (list->string (reverse (string->list s))))))

  (define (prime? x)
    (cond
      [(<= x 1) #f]
      [(= x 2) #t]
      [(even? x) #f]
      [else
       (let loop ([i 3])
         (cond
           [(> (* i i) x) #t]
           [(zero? (modulo x i)) #f]
           [else (loop (+ i 2))]))])))

  (let loop ([x (max n 2)])
    (cond
      [(and (palindrome? x) (prime? x)) x]
      [else (loop (+ x 1))])))