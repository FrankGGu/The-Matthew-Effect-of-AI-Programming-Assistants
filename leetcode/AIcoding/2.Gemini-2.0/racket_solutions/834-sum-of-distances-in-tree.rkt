(define (sum-of-distances-in-tree n edges)
  (define adj (make-vector n null))
  (for-each (lambda (edge)
              (let ((u (first edge)) (v (second edge)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            edges)

  (define count (make-vector n 1))
  (define ans (make-vector n 0))

  (define (dfs root parent)
    (for-each (lambda (neighbor)
                (when (not (= neighbor parent))
                  (dfs neighbor root)
                  (vector-set! count root (+ (vector-ref count root) (vector-ref count neighbor)))
                  (vector-set! ans root (+ (vector-ref ans root) (vector-ref ans neighbor) (vector-ref count neighbor)))))
              (vector-ref adj root)))

  (dfs 0 -1)

  (define (dfs2 root parent)
    (for-each (lambda (neighbor)
                (when (not (= neighbor parent))
                  (vector-set! ans neighbor (+ (vector-ref ans root) (- n (* 2 (vector-ref count neighbor)))))
                  (dfs2 neighbor root)))
              (vector-ref adj root)))

  (dfs2 0 -1)

  (vector->list ans))