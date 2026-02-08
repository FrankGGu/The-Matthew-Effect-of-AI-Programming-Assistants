(define (discount-prices sentence discount)
  (define (apply-discount word)
    (if (and (string-prefix? word "$")
             (> (string-length word) 1)
             (string->number (substring word 1)))
        (let* ([num (string->number (substring word 1))]
               [discounted (* num (- 100 discount) 0.01)])
          (string-append "$" (number->string (exact->inexact discounted))))
        word))

  (string-join (map apply-discount (string-split sentence)) " "))