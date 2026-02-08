(define (count-digits n)
  (define (count-helper n digits)
    (if (zero? digits)
        0
        (let* ((digit (modulo digits 10))
               (next-digits (quotient digits 10))
               (count (if (and (not (zero? digit)) (zero? (modulo n digit))) 1 0)))
          (+ count (count-helper n next-digits)))))
  (count-helper n n))

(define (countDigits n)
  (count-digits n))