#lang racket

(define (serialize root)
  (define (helper node)
    (if (null? node)
        "#"
        (string-append (number->string (car node)) "," (helper (cadr node)) "," (helper (caddr node)))))
  (if (null? root) "" (helper root)))

(define (deserialize data)
  (define nodes (string-split data ","))
  (define (helper)
    (when (null? nodes) (error "Invalid data"))
    (let ([val (car nodes)])
      (set! nodes (cdr nodes))
      (if (equal? val "#")
          null
          (let ([num (string->number val)])
            (list num (helper) (helper))))))
  (if (string=? data "") null (helper)))