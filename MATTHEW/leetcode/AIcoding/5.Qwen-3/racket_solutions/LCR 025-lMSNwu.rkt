#lang racket

(define (add-two-numbers l1 l2)
  (define (reverse-list lst)
    (if (null? lst)
        '()
        (append (reverse-list (cdr lst)) (list (car lst)))))

  (define (list->number lst)
    (if (null? lst)
        0
        (+ (* (car lst) (expt 10 (- (length lst) 1)))
           (list->number (cdr lst)))))

  (define (number->list n)
    (if (= n 0)
        '()
        (append (number->list (quotient n 10)) (list (remainder n 10)))))

  (define reversed-l1 (reverse-list l1))
  (define reversed-l2 (reverse-list l2))
  (define num1 (list->number reversed-l1))
  (define num2 (list->number reversed-l2))
  (define sum (+ num1 num2))
  (number->list sum))