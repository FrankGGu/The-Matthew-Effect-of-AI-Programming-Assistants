#lang racket

(define (serialize root)
  (define (helper node)
    (if (null? node)
        "null"
        (string-append (number->string (car node)) ","
                       (helper (cadr node)) ","
                       (helper (caddr node)))))
  (if (null? root)
      "null"
      (helper root)))

(define (deserialize data)
  (define lst (string-split data ","))
  (define (helper)
    (if (null? lst)
        null
        (let ([val (car lst)])
          (set! lst (cdr lst))
          (if (string=? val "null")
              null
              (list (string->number val) (helper) (helper))))))
  (helper))