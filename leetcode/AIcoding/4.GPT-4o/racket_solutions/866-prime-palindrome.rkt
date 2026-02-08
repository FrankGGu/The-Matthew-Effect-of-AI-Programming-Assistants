(define (is-prime n)
  (cond
    [(< n 2) #f]
    [(= n 2) #t]
    [(even? n) #f]
    [else
     (define (check-divisor d)
       (if (> (* d d) n)
           #t
           (if (= (remainder n d) 0)
               #f
               (check-divisor (+ d 1))))
     (check-divisor 3)]))

(define (is-palindrome n)
  (define str (number->string n))
  (equal? str (string-reverse str)))

(define (next-palindrome n)
  (let loop ((x (+ n 1)))
    (if (is-palindrome x)
        x
        (loop (+ x 1)))))

(define (prime-palindrome n)
  (define (find-palindrome p)
    (if (and (is-prime p) (>= p n))
        p
        (find-palindrome (next-palindrome p))))
  (find-palindrome (if (<= n 2) 2 n)))

(define (primePalindrome n)
  (prime-palindrome n))