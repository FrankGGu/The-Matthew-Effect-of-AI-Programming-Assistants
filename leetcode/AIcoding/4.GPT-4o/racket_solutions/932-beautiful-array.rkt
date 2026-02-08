(define (beautifulArray n)
  (define (helper x)
    (if (= x 1) (list 1)
        (append (helper (/ (+ x 1) 2)) 
                (map (lambda (y) (+ y (/ (+ x 1) 2))) 
                     (helper (/ x 2))))))
  (helper n))

(define (beautifulArray-main n)
  (beautifulArray n))

(define (main)
  (beautifulArray-main 5))

(main)