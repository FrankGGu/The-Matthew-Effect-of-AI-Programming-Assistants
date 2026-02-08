#lang racket

(define (is-sub-structure A B)
  (define (helper A B)
    (cond
      [(null? B) #t]
      [(null? A) #f]
      [(not (= (car A) (car B))) #f]
      [else (and (helper (cadr A) (cadr B)) (helper (caddr A) (caddr B))]))
  (cond
    [(or (null? A) (null? B)) #f]
    [(helper A B) #t]
    [else (or (is-sub-structure (cadr A) B) (is-sub-structure (caddr A) B))]))