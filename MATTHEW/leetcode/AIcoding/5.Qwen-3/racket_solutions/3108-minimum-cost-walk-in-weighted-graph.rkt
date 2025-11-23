#lang racket

(define (minimum-cost-walk n edges start end)
  (define graph (make-hash))
  (for-each
   (lambda (e)
     (let ([u (car e)] [v (cadr e)] [w (caddr e)])
       (hash-set! graph u (cons (cons v w) (hash-ref graph u '())))))
   edges)
  (define (dijkstra)
    (define dist (make-hash))
    (for ([i (in-range n)]) (hash-set! dist i +inf.0))
    (hash-set! dist start 0)
    (define pq (list (cons 0 start)))
    (while (not (null? pq))
      (let* ([current (caar pq)]
             [u (cdar pq)]
             [new-pq (cdr pq)])
        (set! pq new-pq)
        (when (< current (hash-ref dist u))
          (for-each
           (lambda (neighbor)
             (let ([v (car neighbor)] [w (cdr neighbor)])
               (let ([new-dist (+ current w)])
                 (when (< new-dist (hash-ref dist v))
                   (hash-set! dist v new-dist)
                   (set! pq (cons (cons new-dist v) pq))))))
           (hash-ref graph u)))))
    (hash-ref dist end))
  (dijkstra))