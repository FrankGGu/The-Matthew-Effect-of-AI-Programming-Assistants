(define (findElements root)
  (define (dfs node val)
    (when node
      (set! (node-value node) val)
      (dfs (left node) (* 2 val))
      (dfs (right node) (+ (* 2 val) 1)))
    val)

  (define (contains value)
    (set! (val-set value) #t)
    (if (hash-ref val-set value #f)
        #t
        #f))

  (define val-set (make-hash))
  (dfs root 0)
  contains)