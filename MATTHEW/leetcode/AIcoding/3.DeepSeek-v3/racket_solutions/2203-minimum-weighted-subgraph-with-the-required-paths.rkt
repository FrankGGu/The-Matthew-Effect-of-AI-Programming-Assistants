#lang racket

(require data/heap)

(define (minimum-weight n edges src1 src2 dest)
  (define (dijkstra start)
    (define dist (make-vector n +inf.0))
    (vector-set! dist start 0)
    (define heap (make-heap (λ (a b) (<= (car a) (car b))))))
    (heap-add! heap (cons 0 start))
    (let loop ()
      (unless (zero? (heap-count heap))
        (match-define (cons d u) (heap-min heap))
        (heap-remove! heap)
        (when (= d (vector-ref dist u))
          (for ([edge (in-list edges)])
            (match-define (list v w weight) edge)
            (when (and (= u v) (> (+ d weight) (vector-ref dist w)))
              (when (< (+ d weight) (vector-ref dist w))
                (vector-set! dist w (+ d weight))
                (heap-add! heap (cons (+ d weight) w)))))
          (loop))))
    dist)

  (define dist-src1 (dijkstra src1))
  (define dist-src2 (dijkstra src2))

  (define rev-edges (map (λ (e) (list (third e) (second e) (first e))) edges))
  (define dist-dest (dijkstra dest))

  (define min-weight +inf.0)
  (for ([x (in-range n)])
    (define total (+ (vector-ref dist-src1 x) (vector-ref dist-src2 x) (vector-ref dist-dest x)))
    (when (< total min-weight)
      (set! min-weight total)))

  (if (= min-weight +inf.0) -1 min-weight))