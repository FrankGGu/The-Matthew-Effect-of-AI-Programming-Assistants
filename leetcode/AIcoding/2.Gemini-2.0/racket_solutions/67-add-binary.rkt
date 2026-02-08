(define (add-binary a b)
  (letrec ((bin->int (lambda (s) (string->number s 2)))
           (int->bin (lambda (n) (number->string n 2))))
    (int->bin (+ (bin->int a) (bin->int b)))))