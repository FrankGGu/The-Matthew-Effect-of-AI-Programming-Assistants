#lang racket

(define (can-be-sorted nums)
  (define sorted-nums (sort nums <))
  (define (is-unique lst)
    (cond [(null? lst) #t]
          [(null? (cdr lst)) #t]
          [(= (car lst) (cadr lst)) #f]
          [else (is-unique (cdr lst))]))
  (define (check lst1 lst2)
    (cond [(and (null? lst1) (null? lst2)) #t]
          [(or (null? lst1) (null? lst2)) #f]
          [(= (car lst1) (car lst2)) (check (cdr lst1) (cdr lst2))]
          [else #f]))
  (if (is-unique nums)
      (check nums sorted-nums)
      #f))