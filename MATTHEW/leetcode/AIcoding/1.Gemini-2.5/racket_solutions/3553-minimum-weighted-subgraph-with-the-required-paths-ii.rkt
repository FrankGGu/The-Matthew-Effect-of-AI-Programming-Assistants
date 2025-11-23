#lang racket
(require data/heap)

(define INF (expt 10 15))

(define (dijkstra start-node graph n)
  (define distances (make-vector n INF))
  (vector-set! distances start-node 0)

  (define pq (heap-add (heap-empty (lambda (a b) (< (car a) (car b))))
                       (list 0 start-node)))

  (let loop ((current-pq pq))
    (if (heap-empty? current-pq)
        distances
        (let-values (((min-val next-pq) (heap-min/remove current-pq)))
          (define current-dist (car min-val))
          (define u (cadr min-val))

          (if (= current-dist (vector-ref distances u))
              (let ((updated-pq
                     (foldl (lambda (edge acc-pq)
                              (define v (car edge))
                              (define weight (cadr edge))
                              (if (< (+ current-dist weight) (vector-ref distances v))
                                  (begin
                                    (vector-set! distances v (+ current-dist weight))
                                    (heap-add acc-pq (list (vector-ref distances v) v)))
                                  acc-pq))
                            next-pq
                            (vector-ref graph u))))
                (loop updated-pq))
              (loop next-pq))))))

(define (minimum-weighted-subgraph n edges node1 node2 node3)
  (define adj (make-vector n '()))
  (define rev-adj (make-vector n '()))

  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (define w (caddr edge))
              (vector-set! adj u (cons (list v w) (vector-ref adj u)))
              (vector-set! rev-adj v (cons (list u w) (vector-ref rev-adj v))))
            edges)

  (define dist1 (dijkstra node1 adj n))
  (define dist2 (dijkstra node2 adj n))
  (define dist3 (dijkstra node3 rev-adj n))

  (define min-total-weight INF)

  (for ((v (range n)))
    (define d1 (vector-ref dist1 v))
    (define d2 (vector-ref dist2 v))
    (define d3 (vector-ref dist3 v))
    (when (and (< d1 INF) (< d2 INF) (< d3 INF))
      (set! min-total-weight (min min-total-weight (+ d1 d2 d3)))))

  (if (= min-total-weight INF)
      -1
      min-total-weight))