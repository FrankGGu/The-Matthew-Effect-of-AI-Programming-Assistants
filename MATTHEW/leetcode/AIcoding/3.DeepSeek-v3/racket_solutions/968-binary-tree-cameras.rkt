#lang racket

(define (min-camera-cover root)
  (define (helper node)
    (if (null? node)
        (list 1 0 0)
        (let* ([left (helper (car node))]
               [right (helper (cdr node))]
               [min-l (min (car left) (cadr left))]
               [min-r (min (car right) (cadr right))]
               [d0 (+ (car left) (car right))]
               [d1 (+ (min (car left) (cadr left)) 
                    (min (car right) (cadr right)) 
                    1)]
               [d2 (+ (cadr left) (cadr right))])
          (list d0 d1 d2))))
  (let ([res (helper root)])
    (min (car res) (cadr res))))

(define (make-tree lst)
  (if (null? lst)
      '()
      (let ([val (car lst)])
        (if (null? val)
            '()
            (cons (make-tree (cadr lst)) (make-tree (caddr lst)))))))