(define (nearest-palindrome n)
  (define (is-palindrome num)
    (equal? (number->string num) (string-reverse (number->string num))))

  (define (generate-candidates n)
    (let* ([len (string-length n)]
           [prefix (substring n 0 (add1 (quotient len 2)))])
      (define candidates (list))
      (for ([i (list (- (string->number prefix) 1) (string->number prefix) (+ (string->number prefix) 1))])
        (for ([j (list 0 1 -1)])
          (let ([pal (string->number (if (even? len)
                                         (string-append (number->string i) (reverse (number->string i)))
                                         (string-append (number->string i) (substring (reverse (number->string i)) 1)) )))]
            (when (and (not (= pal (string->number n))) (> pal 0))
              (set! candidates (cons pal candidates))))))
      (set! candidates (cons (expt 10 (- len 1)) candidates))
      (set! candidates (cons (expt 10 len) candidates))
      candidates))

  (define candidates (generate-candidates n))
  (define closest (apply min (filter (lambda (x) (and (is-palindrome x) (not (= x (string->number n))))) candidates)))
  closest)

(define (findClosestPalindrome n)
  (nearest-palindrome n))