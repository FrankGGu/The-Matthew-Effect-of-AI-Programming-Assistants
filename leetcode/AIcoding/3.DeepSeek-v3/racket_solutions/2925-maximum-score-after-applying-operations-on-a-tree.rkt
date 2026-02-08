#lang racket

(define (maximum-score-after-operations edges values)
  (define n (length values))
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (define visited (make-vector n #f))
  (define (dfs u parent)
    (vector-set! visited u #t)
    (let ([sum 0]
          [min-child (if (null? (vector-ref adj u)) 
                         +inf.0 
                         (let loop ([children (vector-ref adj u)]
                                    [min-c +inf.0])
                           (if (null? children)
                               min-c
                               (let ([v (car children)])
                                 (if (or (eq? v parent) (vector-ref visited v))
                                     (loop (cdr children) min-c)
                                     (let ([child-val (dfs v u)])
                                       (set! sum (+ sum child-val))
                                       (loop (cdr children) (min min-c child-val)))))))])
      (if (eq? min-child +inf.0)
          (list (vector-ref values u) 0)
          (let ([take-u (vector-ref values u)]
                [not-take-u sum])
            (list (max take-u (+ take-u min-child)) not-take-u)))))

  (let ([result (dfs 0 -1)])
    (max (car result) (cadr result))))