#lang racket

(define (maximum-points coins edges k)
  (define graph (make-hash))
  (for ([edge edges])
    (hash-update! graph (first edge) (lambda (lst) (cons (second edge) lst)) '())
    (hash-update! graph (second edge) (lambda (lst) (cons (first edge) lst)) '()))

  (define visited (make-hash))
  (define (dfs node parent)
    (hash-set! visited node #t)
    (define children (filter (lambda (x) (not (equal? x parent))) (hash-ref graph node '())))
    (define-values (take notake) (for/fold ([take-acc 0] [notake-acc 0]) ([child children])
                                   (define-values (child-take child-notake) (dfs child node))
                                   (values (+ take-acc child-notake)
                                           (+ notake-acc (max child-take child-notake)))))
    (define take-val (- (list-ref coins node) k))
    (define notake-val (quotient (list-ref coins node) 2))
    (values (max take-val (+ take take-val)) (max notake-val (+ notake notake-val))))

  (define-values (res-take res-notake) (dfs 0 -1))
  (max res-take res-notake))