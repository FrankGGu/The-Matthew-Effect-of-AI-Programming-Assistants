#lang racket

(define (is-unival-tree root)
  (if (null? root)
      #t
      (let ([val (car root)])
        (define (helper node)
          (or (null? node)
              (and (= (car node) val)
                   (helper (cadr node))
                   (helper (caddr node)))))
        (helper root))))