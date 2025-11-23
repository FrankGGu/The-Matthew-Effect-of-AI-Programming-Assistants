#lang racket

(define (isTransformable s t)
  (define (can-transform s t)
    (cond
      [(null? s) (null? t)]
      [(null? t) #f]
      [(equal? (car s) (car t)) (can-transform (cdr s) (cdr t))]
      [(and (<= (car t) (car s)) (member (car t) s)) 
       (can-transform (remove (car t) s) (cdr t))]
      [else #f]))

  (can-transform (map char->integer (string->list s)) 
                 (map char->integer (string->list t))))

(define (checkIfTransformable s t)
  (isTransformable s t))

(checkIfTransformable "84532" "34852") ; Example usage