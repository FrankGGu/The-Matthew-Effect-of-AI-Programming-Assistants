(define (getHint secret guess)
  (define bulls (length (filter (lambda (i) (equal? (string-ref secret i) (string-ref guess i))) (range (string-length secret)))))
  (define cows (length (filter (lambda (c) (and (not (equal? (string-ref secret c) (string-ref guess c))) 
                                                 (string-contains? secret (string-ref guess c)))) 
                               (range (string-length guess)))))
  (string-append (number->string bulls) "A" (number->string (- cows bulls)) "B"))

(define (main)
  (getHint "1807" "7810"))

(main)