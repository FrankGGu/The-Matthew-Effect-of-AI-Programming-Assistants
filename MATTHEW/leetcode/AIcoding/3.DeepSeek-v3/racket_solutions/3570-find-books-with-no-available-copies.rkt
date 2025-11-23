#lang racket

(define/contract (find-books books)
  (-> (listof (listof string?)) (listof string?))
  (for/list ([book books]
             #:when (equal? (third book) "0"))
    (first book))