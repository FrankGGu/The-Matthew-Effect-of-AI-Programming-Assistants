(define (largest-3-same-digit-number s)
  (define (count-digit x)
    (length (filter (lambda (c) (equal? c x)) s)))
  (define (largest)
    (for/fold ([max -1]) ([d (in-range 10)])
      (if (>= (count-digit (integer->char (+ d 48))) 3)
          (max max (* d 111)) ; 111 represents ddd
          max)))
  (if (= (largest) -1) "-1" (number->string (largest))))