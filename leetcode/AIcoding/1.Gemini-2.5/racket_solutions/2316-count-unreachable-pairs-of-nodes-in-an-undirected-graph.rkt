(define (count-unreachable-pairs n edges)
  (define adj (make-vector n '()))
  (for-each
   (lambda (edge)
     (let ((u (car edge))
           (v (cadr edge)))
       (vector-set! adj u (cons v (vector-ref adj u)))
       (vector-set! adj v (cons u (vector-ref adj v)))))
   edges)

  (define visited (make-vector n #f))
  (define component-sizes '())

  (define (dfs-recursive node)
    (vector-set! visited node #t)
    (let ((size 1))
      (for-each
       (lambda (neighbor)
         (unless (vector-ref visited neighbor)
           (set! size (+ size (dfs-recursive neighbor)))))
       (vector-ref adj node))
      size))

  (for ([i (in-range n)])
    (unless (vector-ref visited i)
      (let ((size (dfs-recursive i)))
        (set! component-sizes (cons size component-sizes)))))

  (define total-unreachable-pairs 0)
  (define remaining-nodes n)

  (for-each
   (lambda (size)
     (set! total-unreachable-pairs (+ total-unreachable-pairs (* size (- remaining-nodes size))))
     (set! remaining-nodes (- remaining-nodes size)))
   component-sizes)

  total-unreachable-pairs)