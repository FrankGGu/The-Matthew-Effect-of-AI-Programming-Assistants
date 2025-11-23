(define (reverse-number n)
  (let loop ((num n) (rev 0))
    (if (zero? num)
        rev
        (loop (quotient num 10)
              (+ (* rev 10) (remainder num 10))))))

(define (sum-of-number-and-its-reverse num)
  (let loop ((x 0))
    (cond
      ((> x num) #f)
      ((= (+ x (reverse-number x)) num) #t)
      (else (loop (+ x 1))))))