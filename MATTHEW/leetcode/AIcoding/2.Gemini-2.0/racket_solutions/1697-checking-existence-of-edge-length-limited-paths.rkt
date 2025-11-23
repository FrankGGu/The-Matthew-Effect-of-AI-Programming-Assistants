(define (distance-limited-paths-exist? n edge-list queries)
  (define uf (new-union-find n))
  (define sorted-edges (sort edge-list (lambda (a b) (< (third a) (third b)))))
  (define sorted-queries (sort (map (lambda (i q) (append q (list i))) (range (length queries)) queries) (lambda (a b) (< (third a) (third b)))))
  (define result (make-vector (length queries) #f))
  (define edge-index 0)

  (for ([query sorted-queries])
    (define u (first query))
    (define v (second query))
    (define limit (third query))
    (define query-index (fourth query))

    (for ([i (in-range edge-index (length sorted-edges))])
      (define edge (list-ref sorted-edges i))
      (define u1 (first edge))
      (define v1 (second edge))
      (define weight (third edge))
      (if (< weight limit)
          (union-find-union! uf u1 v1)
          (begin
            (set! edge-index i)
            (break)))
      (set! edge-index i))

    (vector-set! result query-index (union-find-connected? uf u v)))

  (vector->list result))