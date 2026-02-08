#lang racket

(require data/heap)

(define (minimum-weighted-subgraph n edges source1 source2 dest)
  (define +infinity+ (expt 10 18))

  (define graph (make-vector n '()))
  (define rev-graph (make-vector n '()))

  (for-each
   (lambda (edge)
     (define u (car edge))
     (define v (cadr edge))
     (define w (caddr edge))
     (vector-set! graph u (cons (list v w) (vector-ref graph u)))
     (vector-set! rev-graph v (cons (list u w) (vector-ref rev-graph v))))
   edges)

  (define (dijkstra graph-adj start-node)
    (define distances (make-vector n +infinity+))
    (when (and (>= start-node 0) (< start-node n))
      (vector-set! distances start-node 0))

    (define pq (make-heap (lambda (a b) (< (car a) (car b)))))

    (when (and (>= start-node 0) (< start-node n))
      (heap-add! pq (list 0 start-node)))

    (while (not (heap-empty? pq))
      (define current-item (heap-min-pop! pq))
      (define d (car current-item))
      (define u (cadr current-item))

      (when (= d (vector-ref distances u))
        (for-each
         (lambda (edge)
           (define v (car edge))
           (define w (cadr edge))
           (when (< (+ d w) (vector-ref distances v))
             (vector-set! distances v (+ d w))
             (heap-add! pq (list (+ d w) v))))
         (vector-ref graph-adj u))))
    distances)

  (define dist1 (dijkstra graph source1))
  (define dist2 (dijkstra graph source2))
  (define dist3 (dijkstra rev-graph dest))

  (define min-total-weight +infinity+)

  (for ([i (in-range n)])
    (define d1i (vector-ref dist1 i))
    (define d2i (vector-ref dist2 i))
    (define d3i (vector-ref dist3 i))

    (when (and (< d1i +infinity+)
               (< d2i +infinity+)
               (< d3i +infinity+))
      (set! min-total-weight (min min-total-weight (+ d1i d2i d3i)))))

  (if (= min-total-weight +infinity+)
      -1
      min-total-weight))