(define (complex-number-multiply a b)
  (define (parse-complex s)
    (let ([plus-index (string-index s "+")])
      (let ([real-part (substring s 0 plus-index)]
            [imag-part (substring s (+ plus-index 1) (- (string-length s) 1))])
        (values (string->number real-part) (string->number imag-part)))))

  (define (format-complex real imag)
    (string-append (number->string real) "+" (number->string imag) "i"))

  (define-values (a-real a-imag) (parse-complex a))
  (define-values (b-real b-imag) (parse-complex b))

  (let ([real (* a-real b-real) (- (* a-imag b-imag))]
        [imag (+ (* a-real b-imag) (* a-imag b-real))])
    (format-complex real imag)))