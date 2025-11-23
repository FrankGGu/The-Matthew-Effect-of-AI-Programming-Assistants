#lang racket

(define (minimum-fuel-cost n roads)
  (define graph (make-hash))
  (for ([road roads])
    (define u (car road))
    (define v (cadr road))
    (hash-set! graph u (cons v (hash-ref graph u '())))
    (hash-set! graph v (cons u (hash-ref graph v '()))))

  (define (dfs node parent)
    (define children (hash-ref graph node '()))
    (if (null? children)
        0
        (let loop ([children children] [total 0])
          (if (null? children)
              total
              (let* ([child (car children)]
                     [cost (dfs child node)])
                (loop (cdr children) (+ total cost (if (= child parent) 0 1))))))))

  (dfs 0 -1))