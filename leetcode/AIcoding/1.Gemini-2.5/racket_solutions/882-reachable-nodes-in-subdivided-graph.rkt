#lang racket

(require racket/hash)
(require racket/vector)
(require racket/heap)

(define (reachable-nodes-in-subdivided-graph edges max-moves n)
  (define graph (make-hash))

  (for-each
   (lambda (edge)
     (define u (first edge))
     (define v (second edge))
     (define k (third edge))
     (hash-set! graph u (cons (list v k) (hash-ref graph u '())))
     (hash-set! graph v (cons (list u k) (hash-ref graph v '()))))
   edges)

  (define dist (make-vector n +inf.0))
  (vector-set! dist 0 0)

  (define pq (make-heap < (lambda (a b) (< (car a) (car b)))))
  (heap-add! pq (list 0 0))

  (let loop ()
    (when (not (heap-empty? pq))
      (define current-item (heap-min-pop! pq))
      (define d (first current-item))
      (define u (second current-item))

      (when (> d (vector-ref dist u))
        (loop))

      (for-each
       (lambda (neighbor-info)
         (define v (first neighbor-info))
         (define k (second neighbor-info))
         (define edge-cost (+ k 1))

         (when (< (+ d edge-cost) (vector-ref dist v))
           (vector-set! dist v (+ d edge-cost))
           (heap-add! pq (list (vector-ref dist v) v))))
       (hash-ref graph u '()))
      (loop)))

  (define total-reachable-nodes 0)

  (for ([i (in-range n)])
    (when (<= (vector-ref dist i) max-moves)
      (set! total-reachable-nodes (+ total-reachable-nodes 1))))

  (for-each
   (lambda (edge)
     (define u (first edge))
     (define v (second edge))
     (define k (third edge))

     (define reachable-from-u-to-v
       (if (<= (vector-ref dist u) max-moves)
           (min k (- max-moves (vector-ref dist u)))
           0))

     (define reachable-from-v-to-u
       (if (<= (vector-ref dist v) max-moves)
           (min k (- max-moves (vector-ref dist v)))
           0))

     (set! total-reachable-nodes
           (+ total-reachable-nodes (min k (+ reachable-from-u-to-v reachable-from-v-to-u)))))
   edges)

  total-reachable-nodes)