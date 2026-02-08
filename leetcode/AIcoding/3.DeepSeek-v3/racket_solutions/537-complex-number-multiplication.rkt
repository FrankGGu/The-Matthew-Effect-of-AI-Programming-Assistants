(define (complex-number-multiply num1 num2)
  (let* ([split1 (string-split num1 "+")]
         [split2 (string-split num2 "+")]
         [a (string->number (car split1))]
         [b (string->number (substring (cadr split1) 0 (- (string-length (cadr split1)) 1)))]
         [c (string->number (car split2))]
         [d (string->number (substring (cadr split2) 0 (- (string-length (cadr split2)) 1)))])
    (string-append (number->string (- (* a c) (* b d))) "+" (number->string (+ (* a d) (* b c))) "i")))