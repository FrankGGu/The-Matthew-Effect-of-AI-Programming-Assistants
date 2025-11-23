#lang racket

(define (is-valid-bst root)
  (define (helper node low high)
    (cond [(not node) #t]
          [(or (<= (car node) low) (>= (car node) high)) #f]
          [else (and (helper (cadr node) low (car node))
                     (helper (caddr node) (car node) high))]))
  (helper root -inf.0 +inf.0))