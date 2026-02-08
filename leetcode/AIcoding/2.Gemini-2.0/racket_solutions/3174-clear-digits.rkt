(define (clear-digits n)
  (let loop ([n n] [res '()])
    (cond
      [(zero? n) (if (empty? res) 0 (string->number (list->string (reverse res))))]
      [(even? (modulo n 10)) (loop (quotient n 10) res)]
      [else (loop (quotient n 10) (cons (number->string (modulo n 10)) res))])))