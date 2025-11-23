(define (gcd a b)
  (if (zero? b) a (gcd b (modulo a b))))

(define (parse-fraction s)
  (let* ([parts (regexp-match #rx"^(-?)([0-9]+)/([0-9]+)$" s)])
    (if parts
        (let* ([sign (if (equal? (second parts) "-") -1 1)]
               [num (string->number (third parts))]
               [den (string->number (fourth parts))])
          (cons (* sign num) den))
        (cons 0 1))))

(define (add-fractions f1 f2)
  (let* ([num1 (car f1)]
         [den1 (cdr f1)]
         [num2 (car f2)]
         [den2 (cdr f2)]
         [new-den (* den1 den2)]
         [new-num (+ (* num1 den2) (* num2 den1))])
    (let ([g (gcd (abs new-num) new-den)])
      (cons (/ new-num g) (/ new-den g)))))

(define (fraction-addition-and-subtraction expression)
  (let* ([fractions (regexp-match* #rx"-?[0-9]+/[0-9]+" expression)]
         [parsed (map parse-fraction fractions)]
         [result (foldl add-fractions (cons 0 1) parsed)])
    (format "~a/~a" (car result) (cdr result))))