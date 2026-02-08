(define (largestPalindromeDivisibleByK n k)
  (define (make-palindrome s)
    (string-append s (string-reverse s)))

  (define (check-palindrome s)
    (equal? s (string-reverse s)))

  (define (string->number s)
    (string->number/locale s #f))

  (define (number->string n)
    (number->string n))

  (define (find-largest-palindrome-divisible-by-k start end)
    (for/first ([i (in-range end start -1)])
      #:when (and (check-palindrome (number->string i))
                   (zero? (modulo (string->number (make-palindrome (number->string i))) k)))
      (make-palindrome (number->string i))))

  (cond
    [(equal? n 1) (if (equal? k 2) "1" "9")]
    [(= k 1) (make-string n #\9)]
    [else
     (let ([start (expt 10 (- n 1))])
       (let ([end (expt 10 n)])
         (let ([result (find-largest-palindrome-divisible-by-k (sub1 end) start)])
           (if (equal? result #f)
               ""
               result))))]))