(define (smallest-divisible-digit-product n)
  (cond [(< n 10) n]
        [(= n 1) 1]
        [else
         (let loop ([digits '()] [num n])
           (cond [(= num 1)
                  (if (null? digits)
                      -1
                      (string->number (list->string (reverse (map number->string digits)))))]
                 [(<= num 0) -1]
                 [else
                  (let ([d (findf (lambda (x) (and (not (= x 1)) (= (remainder num x) 0))) '(9 8 7 6 5 4 3 2))])
                    (if d
                        (loop (cons d digits) (/ num d))
                        -1))]))]))