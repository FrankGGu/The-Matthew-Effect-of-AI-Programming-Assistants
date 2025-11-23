#lang racket

(define (is-subtree s t)
  (define (equal? a b)
    (cond [(and (not a) (not b)) #t]
          [(or (not a) (not b)) #f]
          [else (and (= (car a) (car b))
                     (equal? (cadr a) (cadr b))
                     (equal? (caddr a) (caddr b)))]))

  (define (traverse node)
    (cond [(not node) #f]
          [(equal? node t) #t]
          [else (or (traverse (cadr node))
                    (traverse (caddr node)))]))

  (traverse s))