(define (valid-palindrome? s)
  (define (is-palindrome? str)
    (equal? str (string-reverse str)))

  (define (valid-palindrome-helper str l r)
    (cond
      [(>= l r) #t]
      [(= (string-ref str l) (string-ref str r)) (valid-palindrome-helper str (+ l 1) (- r 1))]
      [else #f]))

  (define (valid-palindrome-with-removal str l r)
    (cond
      [(>= l r) #t]
      [(= (string-ref str l) (string-ref str r)) (valid-palindrome-with-removal str (+ l 1) (- r 1))]
      [else (or (valid-palindrome-helper str (+ l 1) r)
                 (valid-palindrome-helper str l (- r 1)))]))

  (valid-palindrome-with-removal s 0 (- (string-length s) 1)))