#lang racket

(define (is-subtree root sub-root)
  (cond
    [(null? sub-root) #t]
    [(null? root) #f]
    [(same-tree? root sub-root) #t]
    [else (or (is-subtree (left-child root) sub-root)
              (is-subtree (right-child root) sub-root))]))

(define (same-tree? s t)
  (cond
    [(and (null? s) (null? t)) #t]
    [(or (null? s) (null? t)) #f]
    [(not (= (val s) (val t))) #f]
    [else (and (same-tree? (left-child s) (left-child t))
               (same-tree? (right-child s) (right-child t)))]))

(define (val node) (if (null? node) null (car node)))
(define (left-child node) (if (null? node) null (cadr node)))
(define (right-child node) (if (null? node) null (caddr node)))