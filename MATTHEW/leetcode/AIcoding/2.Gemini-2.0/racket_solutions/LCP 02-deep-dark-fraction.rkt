(define (fraction->string n d)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

  (let ((common-divisor (gcd n d)))
    (format "~a/~a" (/ n common-divisor) (/ d common-divisor))))

(define (deep-dark-fraction cont)
  (let loop ((cont cont) (p 0) (q 1) (r 1) (s 0))
    (cond
      [(null? cont)
       (fraction->string (+ p r) (+ q s))]
      [else
       (let ((a (car cont)))
         (loop (cdr cont) r s (+ p (* a r)) (+ q (* a s))))])))