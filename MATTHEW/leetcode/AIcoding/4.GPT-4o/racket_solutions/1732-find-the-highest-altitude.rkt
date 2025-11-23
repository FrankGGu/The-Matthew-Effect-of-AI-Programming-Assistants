(define (largestAltitude gain)
  (define (max-altitude lst)
    (if (null? lst)
        0
        (max (car lst) (max-altitude (cdr lst)))))
  (define heights (map (lambda (x) (if (null? x) 0 (+ (if (null? (cdr x)) 0 (car (cdr x))) (car x)))) (inits (cons 0 gain))))
  (max-altitude heights))