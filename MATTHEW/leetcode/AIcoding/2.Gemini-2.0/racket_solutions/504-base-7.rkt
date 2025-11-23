(define (convertToBase7 n)
  (cond
    [(zero? n) "0"]
    [else
     (let loop ([n (abs n)] [acc '()])
       (if (zero? n)
           (string-append (if (< n 0) "-" "") (list->string (reverse acc)))
           (loop (quotient n 7) (cons (integer->char (+ (remainder n 7) 48)) acc))))
     ]))