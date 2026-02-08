#lang racket

(struct Graph (edges) #:transparent)

(define (create-graph)
  (Graph (hash)))

(define (add-edge graph u v w)
  (let ([edges (Graph-edges graph)])
    (hash-set! edges u (cons (cons v w) (hash-ref edges u '()))))
    (hash-set! edges v (cons (cons u w) (hash-ref edges v '())))
    (Graph edges)))

(define (shortest-path graph start end)
  (define (dijkstra)
    (define queue (make-pqueue '((0 . ,start))))
    (define distances (hash))
    (define previous (hash))

    (for ([node (in-hash-keys (Graph-edges graph))])
      (hash-set! distances node +inf.0)
      (hash-set! previous node #f))

    (hash-set! distances start 0)

    (define (update-distance node neighbor weight)
      (let ([new-dist (+ (hash-ref distances node) weight)])
        (when (< new-dist (hash-ref distances neighbor))
          (hash-set! distances neighbor new-dist)
          (hash-set! previous neighbor node)
          (pqueue-add! queue (cons new-dist neighbor)))))

    (while (not (pqueue-empty? queue))
      (define-values (dist u) (pqueue-pop! queue))
      (for ([edge (in-list (hash-ref (Graph-edges graph) u))])
        (define-values (v weight) edge)
        (update-distance u v weight)))

    (define path '())
    (define current end)
    (when (not (= (hash-ref distances end) +inf.0))
      (let loop ()
        (when (not (eq? current #f))
          (set! path (cons current path))
          (set! current (hash-ref previous current))))
      path))

  (dijkstra))

(define (create-graph-and-query)
  (define g (create-graph))
  (define g1 (add-edge g 1 2 1))
  (define g2 (add-edge g1 1 3 4))
  (define g3 (add-edge g2 2 3 2))
  (shortest-path g3 1 3))