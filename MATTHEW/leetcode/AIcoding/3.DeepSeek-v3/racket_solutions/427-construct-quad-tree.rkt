#lang racket

(define (construct grid)
  (define (helper x y size)
    (if (= size 1)
        (let ([val (vector-ref (vector-ref grid x) y)])
          (list (not (zero? val)) #t #t #t #t))
        (let* ([half (quotient size 2)]
               [top-left (helper x y half)]
               [top-right (helper x (+ y half) half)]
               [bottom-left (helper (+ x half) y half)]
               [bottom-right (helper (+ x half) (+ y half) half)]
               [all-leaves (and (cadr top-left) (cadr top-right) (cadr bottom-left) (cadr bottom-right))]
               [all-same (and all-leaves 
                              (equal? (car top-left) (car top-right))
                              (equal? (car top-left) (car bottom-left))
                              (equal? (car top-left) (car bottom-right)))])
          (if all-same
              (list (car top-left) #t #t #t #t)
              (list #f #f top-left top-right bottom-left bottom-right)))))
  (helper 0 0 (vector-length grid)))