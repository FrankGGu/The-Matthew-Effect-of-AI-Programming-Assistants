#lang racket

(require data/heap)

(struct edge (u v w) #:transparent)

(define (shortest-distance-after-road-addition-queries n roads queries)
  (define adj (make-vector n (make-hash)))
  (for ([r roads])
    (let ([u (first r)]
          [v (second r)]
          [w (third r)])
      (hash-set! (vector-ref adj u) v w)
      (hash-set! (vector-ref adj v) u w)))

  (define (dijkstra start)
    (define dist (make-vector n +inf.0))
    (vector-set! dist start 0)
    (define heap (make-heap (lambda (a b) (<= (car a) (car b)))))
    (heap-add! heap (cons 0 start))
    (let loop ()
      (unless (heap-empty? heap)
        (let ([current (heap-min heap)])
          (heap-remove! heap)
          (let ([d (car current)]
                [u (cdr current)])
            (when (<= d (vector-ref dist u))
              (for ([(v w) (in-hash (vector-ref adj u))])
                (let ([new-dist (+ d w)])
                  (when (< new-dist (vector-ref dist v))
                    (vector-set! dist v new-dist)
                    (heap-add! heap (cons new-dist v)))))))
        (loop)))
    dist)

  (define dists (make-vector n #f))
  (for ([i (in-range n)])
    (vector-set! dists i (dijkstra i)))

  (define (query u v)
    (vector-ref (vector-ref dists u) v))

  (for/list ([q queries])
    (let ([u (first q)]
          [v (second q)]
          [w (third q)])
      (let ([old-w (hash-ref (vector-ref adj u) v +inf.0)])
        (when (< w old-w)
          (hash-set! (vector-ref adj u) v w)
          (hash-set! (vector-ref adj v) u w)
          (for ([i (in-range n)])
            (vector-set! dists i (dijkstra i)))))
        (query u v))))