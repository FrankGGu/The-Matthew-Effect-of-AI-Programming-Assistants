#lang racket

(define (distance-limited-paths-exist n edge-list queries)
  (define parent (make-vector n 0))
  (define rank (make-vector n 0))

  (define (find u)
    (if (= (vector-ref parent u) u)
        u
        (let ([p (find (vector-ref parent u))])
          (vector-set! parent u p)
          p)))

  (define (union u v)
    (let ([u-root (find u)]
          [v-root (find v)])
      (cond
        [(= u-root v-root) #f]
        [(< (vector-ref rank u-root) (vector-ref rank v-root))
         (vector-set! parent u-root v-root)]
        [else
         (vector-set! parent v-root u-root)
         (when (= (vector-ref rank u-root) (vector-ref rank v-root))
           (vector-set! rank u-root (+ (vector-ref rank u-root) 1)))])))

  (for ([i (in-range n)])
    (vector-set! parent i i)
    (vector-set! rank i 0))

  (define sorted-edges (sort edge-list (lambda (a b) (< (third a) (third b)))))

  (define sorted-queries
    (for/list ([(q idx) (in-indexed queries)])
      (list (first q) (second q) (third q) idx)))

  (define sorted-queries-by-limit
    (sort sorted-queries (lambda (a b) (< (third a) (third b)))))

  (define result (make-vector (length queries) #f))
  (define edge-ptr 0)

  (for ([query (in-list sorted-queries-by-limit)])
    (let ([u (first query)]
          [v (second query)]
          [limit (third query)]
          [idx (fourth query)])
      (while (and (< edge-ptr (length sorted-edges))
                  (< (third (list-ref sorted-edges edge-ptr)) limit))
        (let ([edge (list-ref sorted-edges edge-ptr)])
          (union (first edge) (second edge))
          (set! edge-ptr (+ edge-ptr 1))))
      (vector-set! result idx (= (find u) (find v)))))

  (vector->list result))