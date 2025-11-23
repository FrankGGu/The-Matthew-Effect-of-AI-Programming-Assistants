(define (find-critical-and-pseudo-critical-edges n edges)
  (define m (length edges))

  (define (kruskal forced-edge excluded-edge)
    (define parent (make-vector n))
    (for ((i (in-range n)))
      (vector-set! parent i i))

    (define (find x)
      (if (equal? (vector-ref parent x) x)
          x
          (let ((root (find (vector-ref parent x))))
            (vector-set! parent x root)
            root)))

    (define (union x y)
      (let ((root-x (find x))
            (root-y (find y)))
        (if (not (equal? root-x root-y))
            (vector-set! parent root-x root-y)
            #f)))

    (define mst-weight 0)
    (define edges-used 0)

    (when forced-edge
      (let ((u (list-ref (list-ref edges (car forced-edge)) 0))
            (v (list-ref (list-ref edges (car forced-edge)) 1))
            (weight (list-ref (list-ref edges (car forced-edge)) 2)))
        (if (not (union u v))
            (return #f)) ; graph is disconnected
        (set! mst-weight (+ mst-weight weight))
        (set! edges-used (+ edges-used 1))))

    (for ((i (in-range m)))
      (when (and (not (equal? i excluded-edge))
                 (or (not forced-edge) (not (equal? i (car forced-edge))))
                )
        (let ((u (list-ref (list-ref edges i) 0))
              (v (list-ref (list-ref edges i) 1))
              (weight (list-ref (list-ref edges i) 2)))
          (when (union u v)
            (set! mst-weight (+ mst-weight weight))
            (set! edges-used (+ edges-used 1))))))

    (if (equal? edges-used (- n 1))
        mst-weight
        #f))

  (define min-mst-weight (kruskal #f #f))

  (define critical-edges '())
  (define pseudo-critical-edges '())

  (for ((i (in-range m)))
    (cond
      [(not min-mst-weight)
       (set! critical-edges (append critical-edges (list i)))]
      [(not (kruskal #f i))
       (set! critical-edges (append critical-edges (list i)))]
      [(let ((forced-mst-weight (kruskal (list i) #f)))
         (and forced-mst-weight
              (not (equal? forced-mst-weight min-mst-weight))))
       (set! critical-edges (append critical-edges (list i)))]
      [(let ((forced-mst-weight (kruskal (list i) #f)))
         (and forced-mst-weight
              (equal? forced-mst-weight min-mst-weight)))
       (set! pseudo-critical-edges (append pseudo-critical-edges (list i)))]))

  (list critical-edges pseudo-critical-edges))

(define (find-critical-and-pseudo-critical-edges-wrapper n edges)
  (define indexed-edges (map (lambda (i edge) (append edge (list i))) (range (length edges)) edges))
  (define sorted-edges (sort indexed-edges (lambda (a b) (< (list-ref a 2) (list-ref b 2)))))

  (define remapped-edges (map (lambda (edge) (list (list-ref edge 0) (list-ref edge 1) (list-ref edge 2))) sorted-edges))

  (define result (find-critical-and-pseudo-critical-edges n remapped-edges))

  (define critical-indices (map (lambda (index) (list-ref (list-ref sorted-edges index) 3)) (car result)))
  (define pseudo-critical-indices (map (lambda (index) (list-ref (list-ref sorted-edges index) 3)) (cadr result)))

  (list critical-indices pseudo-critical-indices))