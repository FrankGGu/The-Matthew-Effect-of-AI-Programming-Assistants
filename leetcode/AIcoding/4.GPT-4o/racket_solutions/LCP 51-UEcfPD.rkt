(define (cook-dishes dishes)
  (define (helper dishes)
    (if (null? dishes)
        0
        (+ (car dishes) (helper (cdr dishes)))))
  (helper dishes))

(cook-dishes '(1 2 3 4 5))