(define (complex-number-multiplication a b)
  (let* ((a-parts (string-split a #\+))
         (b-parts (string-split b #\+))
         (a-real (string->number (car a-parts)))
         (a-imag (string->number (cadr a-parts)))
         (b-real (string->number (car b-parts)))
         (b-imag (string->number (cadr b-parts))))
    (string-append
     (number->string (+ (* a-real b-real) (* -1 a-imag b-imag)))
     "+"
     (number->string (+ (* a-real b-imag) (* a-imag b-real)))
     "i")))