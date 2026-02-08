(define (fractionAddition expression)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))

  (define (add-fractions num1 den1 num2 den2)
    (let* ((common-denom (* den1 den2))
           (new-num (+ (* num1 den2) (* num2 den1))))
      (let ((g (gcd new-num common-denom)))
        (list (/ new-num g) (/ common-denom g)))))

  (define (parse-fractions expr)
    (let loop ((e expr) (num 0) (den 1) (sign 1))
      (cond
        ((null? e) (list num den))
        ((char=? (car e) #\+) (loop (cdr e) num den 1))
        ((char=? (car e) #\-) (loop (cdr e) num den -1))
        ((char=? (car e) #\/) 
         (let* ((next (string->number (substring e 0 (index-of e #\/))))
                (new-den (string->number (substring e (+ 1 (index-of e #\/))))))
           (loop (cddr e) (+ num (* sign next (/ 1 new-den))) den sign)))
        (else (loop (cdr e) num den sign)))))

  (define (reduce-fraction num den)
    (let* ((g (gcd num den)))
      (list (/ num g) (/ den g))))

  (let* ((fractions (parse-fractions (string->list expression)))
         (result (reduce-fraction (car fractions) (cadr fractions))))
    (string-append (number->string (car result)) "/" (number->string (cadr result)))))