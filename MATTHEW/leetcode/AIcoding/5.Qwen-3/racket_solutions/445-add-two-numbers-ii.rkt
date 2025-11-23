#lang racket

(define (add-two-numbers ii)
  (define (reverse-list lst)
    (if (null? lst)
        '()
        (append (reverse-list (cdr lst)) (list (car lst)))))

  (define (to-number lst)
    (if (null? lst)
        0
        (+ (* (car lst) (expt 10 (length (cdr lst))))
           (to-number (cdr lst)))))

  (define (to-list n)
    (if (= n 0)
        '()
        (append (to-list (quotient n 10)) (list (remainder n 10)))))

  (let* ([l1 (reverse-list (car ii))]
         [l2 (reverse-list (cadr ii))]
         [num1 (to-number l1)]
         [num2 (to-number l2)]
         [sum (+ num1 num2)])
    (to-list sum)))