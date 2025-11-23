#lang racket

(define (make-ordinal-tracker)
  (let ([sorted-list '()])
    (lambda (op . args)
      (cond
        [(equal? op 'insert)
         (set! sorted-list (sort (cons (car args) sorted-list) <))]
        [(equal? op 'get)
         (let ([index (- (car args) 1)])
           (list-ref sorted-list index))]))))

(define (main)
  (define tracker (make-ordinal-tracker))
  (printf "~a~n" (tracker 'insert 25))
  (printf "~a~n" (tracker 'insert 35))
  (printf "~a~n" (tracker 'insert 15))
  (printf "~a~n" (tracker 'get 1))
  (printf "~a~n" (tracker 'get 2))
  (printf "~a~n" (tracker 'get 3)))

(main)