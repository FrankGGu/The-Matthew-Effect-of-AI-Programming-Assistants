(define (is-good-number? n)
  (let loop ((num n)
             (found-rotating-digit #f))
    (cond
      ((= num 0) found-rotating-digit)
      (else
       (let ((digit (modulo num 10)))
         (case digit
           ((0 1 8) (loop (quotient num 10) found-rotating-digit))
           ((2 5 6 9) (loop (quotient num 10) #t))
           ((3 4 7) #f)))))))

(define (rotated-digits N)
  (for/fold ((count 0))
            ((i (in-range 1 (+ N 1))))
    (if (is-good-number? i)
        (+ count 1)
        count)))