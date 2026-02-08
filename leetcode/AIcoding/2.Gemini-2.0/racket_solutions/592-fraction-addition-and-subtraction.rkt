(define (fraction-addition expression)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

  (define (lcm a b)
    (/ (* a b) (gcd a b)))

  (define (parse-fraction str)
    (let* ([parts (string-split str "/")]
           [numerator (string->number (car parts))]
           [denominator (string->number (cadr parts))])
      (list numerator denominator)))

  (define (add-fractions frac1 frac2)
    (let* ([num1 (car frac1)]
           [den1 (cadr frac1)]
           [num2 (car frac2)]
           [den2 (cadr frac2)]
           [new-den (lcm den1 den2)]
           [new-num (+ (* num1 (/ new-den den1))
                       (* num2 (/ new-den den2)))]
           [common-divisor (gcd new-num new-den)])
      (list (/ new-num common-divisor) (/ new-den common-divisor))))

  (define (process-expression expr)
    (let loop ([expr expr] [current-fraction (list 0 1)] [i 0])
      (cond
        [(>= i (string-length expr))
         current-fraction]
        [else
         (let ([start-index i])
           (let loop2 ([j i])
             (cond
               [(>= j (string-length expr))
                (let* ([fraction-str (substring expr start-index (string-length expr))]
                       [fraction (parse-fraction fraction-str)])
                  (add-fractions current-fraction fraction))]
               [(or (= (string-ref expr j) #\+) (= (string-ref expr j) #\-))
                (let* ([fraction-str (substring expr start-index j)]
                       [fraction (parse-fraction fraction-str)])
                  (loop expr (add-fractions current-fraction fraction) j))]
               [else
                (loop2 (+ j 1))])))
         ])))

  (let ([result (process-expression expression)])
    (string-append (number->string (car result)) "/" (number->string (cadr result)))))