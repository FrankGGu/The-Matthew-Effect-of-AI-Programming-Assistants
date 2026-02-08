#lang racket

(define (maxRemoveEdges n edges)
  (define (find-parent parent x)
    (if (not (= (vector-ref parent x) x))
        (find-parent parent (vector-ref parent x))
        x))

  (define (union parent rank x y)
    (define rootX (find-parent parent x))
    (define rootY (find-parent parent y))
    (if (not (= rootX rootY))
        (begin
          (if (> (vector-ref rank rootX) (vector-ref rank rootY))
              (begin
                (vector-set! parent rootY rootX)
                (vector-set! rank rootX (+ (vector-ref rank rootX) (vector-ref rank rootY))))
              (begin
                (vector-set! parent rootX rootY)
                (vector-set! rank rootY (+ (vector-ref rank rootX) (vector-ref rank rootY)))))))

  (define parent (vector))
  (define rank (vector))
  (for ([i (in-range n)])
    (vector-set! parent i i)
    (vector-set! rank i 0))

  (define edge-count 0)
  (define remove-count 0)

  (for* ([type (in-list (map car edges))]
         [u (in-list (map cadr edges))]
         [v (in-list (map caddr edges))])
    (cond
      [(= type 3)
       (union parent rank u v)
       (set! edge-count (+ edge-count 1))]
      [(= type 1)
       (union parent rank u v)
       (set! remove-count (+ remove-count 1))]))

  (define component-count 0)
  (for ([i (in-range n)])
    (when (= (vector-ref parent i) i)
      (set! component-count (+ component-count 1))))

  (define total-edges (- edge-count remove-count))
  (if (= component-count 1)
      (values total-edges (max 0 (- (length edges) total-edges)))
      (values total-edges 0)))

(define (removeMaxEdges n edges)
  (define-values (total removed) (maxRemoveEdges n edges))
  (if (= removed 0)
      total
      (error "Not fully traversable after removal")))