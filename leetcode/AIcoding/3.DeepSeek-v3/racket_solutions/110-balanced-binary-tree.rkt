#lang racket

(define (is-balanced root)
  (define (height node)
    (if (null? node)
        0
        (+ 1 (max (height (left node)) (height (right node))))))

  (define (check node)
    (if (null? node)
        #t
        (and (check (left node))
             (check (right node))
             (<= (abs (- (height (left node)) (height (right node)))) 1))))

  (check root))

(define (left node)
  (if (null? node) '() (car (cdr node))))

(define (right node)
  (if (null? node) '() (car (cdr (cdr node))))