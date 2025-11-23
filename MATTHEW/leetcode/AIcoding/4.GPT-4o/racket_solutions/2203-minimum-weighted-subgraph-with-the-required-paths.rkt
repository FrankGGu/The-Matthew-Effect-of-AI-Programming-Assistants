#lang racket

(define (minimum-weighted-subgraph n edges required)
  (define graph (make-vector n '()))
  (for ([edge edges])
    (define a (car edge))
    (define b (cadr edge))
    (define w (caddr edge))
    (vector-set! graph (sub1 a) (cons (list (sub1 b) w) (vector-ref graph (sub1 a))))
    (vector-set! graph (sub1 b) (cons (list (sub1 a) w) (vector-ref graph (sub1 b)))))

  (define (dijkstra start)
    (define dist (make-vector n +inf.0))
    (define pq (make-pq))
    (vector-set! dist start 0)
    (pq-insert! pq (list 0 start))

    (let loop ()
      (unless (pq-empty? pq)
        (define (values (pq-extract-min! pq)))
        (for ([neighbor (vector-ref graph node)])
          (define next-node (car neighbor))
          (define weight (cadr neighbor))
          (when (< (+ distance weight) (vector-ref dist next-node))
            (vector-set! dist next-node (+ distance weight))
            (pq-insert! pq (list (+ distance weight) next-node))))
        (loop)))

  (define total-weight (for/sum ([path required])
                         (let ([u (car path)]
                               [v (cadr path)])
                           (dijkstra (sub1 u))
                           (vector-ref dist (sub1 v)))))

  total-weight)

(define (minimum-weighted-subgraph-with-required-paths n edges required)
  (minimum-weighted-subgraph n edges required))