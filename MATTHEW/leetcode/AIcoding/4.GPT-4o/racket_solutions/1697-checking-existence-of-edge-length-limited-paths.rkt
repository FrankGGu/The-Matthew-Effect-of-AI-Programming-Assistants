#lang racket

(define (edge-existence-queries n edges queries)
  (define graph (make-vector n '()))
  (for ([edge edges])
    (let ([u (vector-ref edge 0)]
          [v (vector-ref edge 1)]
          [w (vector-ref edge 2)])
      (define old (vector-ref graph u))
      (vector-set! graph u (cons (list v w) old))
      (define old (vector-ref graph v))
      (vector-set! graph v (cons (list u w) old))))

  (define (find parent x)
    (if (not (= (vector-ref parent x) x))
        (let ([root (find parent (vector-ref parent x))])
          (vector-set! parent x root)
          root)
        x))

  (define (union parent rank x y)
    (define rootX (find parent x))
    (define rootY (find parent y))
    (if (not (= rootX rootY))
        (if (> (vector-ref rank rootX) (vector-ref rank rootY))
            (vector-set! parent rootY rootX)
            (begin
              (when (= (vector-ref rank rootX) (vector-ref rank rootY))
                (vector-set! rank rootY (+ (vector-ref rank rootY) 1)))
              (vector-set! parent rootX rootY)))))

  (define sorted-edges (sort edges (λ (a b) (> (vector-ref a 2) (vector-ref b 2))))
  (define parent (make-vector n))
  (define rank (make-vector n 0))

  (for ([i (in-range n)])
    (vector-set! parent i i))

  (define results (make-vector (length queries) #f))

  (for ([i (in-range (length queries))])
    (define query (vector-ref queries i))
    (define u (vector-ref query 0))
    (define v (vector-ref query 1))
    (define limit (vector-ref query 2))
    (set! results (vector-set! results i (list u v limit i))))

  (define sorted-queries (sort (vector->list results) (λ (a b) (> (third a) (third b)))))

  (define edge-index 0)
  (for ([query sorted-queries])
    (define u (first query))
    (define v (second query))
    (define limit (third query))
    (while (and (< edge-index (length sorted-edges))
                (> (vector-ref (vector-ref sorted-edges edge-index) 2) limit))
      (define edge (vector-ref sorted-edges edge-index))
      (union parent rank (vector-ref edge 0) (vector-ref edge 1))
      (set! edge-index (+ edge-index 1)))
    (set! results (vector-set! results (fourth query) (= (find parent u) (find parent v)))))

  (vector->list results))

(define (edge-existence-queries-main n edges queries)
  (edge-existence-queries n edges queries))