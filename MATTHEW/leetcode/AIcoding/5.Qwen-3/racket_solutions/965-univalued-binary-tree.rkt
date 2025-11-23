#lang racket

(define (is-univalued root)
  (define (helper node val)
    (if (not node)
        #t
        (and (= (car node) val)
             (helper (cadr node) val)
             (helper (caddr node) val))))
  (if (not root)
      #t
      (helper root (car root))))