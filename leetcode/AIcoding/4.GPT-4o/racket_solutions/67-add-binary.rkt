(define (addBinary a b)
  (define (helper a b carry)
    (cond
      [(and (string-empty? a) (string-empty? b) (zero? carry)) ""]
      [else
       (let* ([sum (+ (if (string-empty? a) 0 (sub1 (string-length a)))
                         (if (string-empty? b) 0 (sub1 (string-length b)))
                         carry)]
              [current (modulo sum 2)]
              [new-carry (quotient sum 2)])
         (string-append (helper (if (string-empty? a) "" (substring a 0 (sub1 (string-length a))))
                                (if (string-empty? b) "" (substring b 0 (sub1 (string-length b))))
                                new-carry)
                        (number->string current)))]))

  (helper a b 0))