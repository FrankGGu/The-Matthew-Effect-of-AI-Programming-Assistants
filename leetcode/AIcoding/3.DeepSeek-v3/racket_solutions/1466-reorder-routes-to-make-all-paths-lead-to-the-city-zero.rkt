(define (min-reorder n connections)
  (define graph (make-hash))
  (define directed (make-hash))

  (for ([conn connections])
    (define u (first conn))
    (define v (second conn))
    (hash-set! graph u (cons v (hash-ref graph u '())))
    (hash-set! graph v (cons u (hash-ref graph v '())))
    (hash-set! directed (cons u v) #t))

  (define visited (make-hash))
  (define res 0)

  (define (dfs node)
    (hash-set! visited node #t)
    (for ([neighbor (hash-ref graph node '())])
      (unless (hash-ref visited neighbor #f)
        (unless (hash-ref directed (cons neighbor node) #f)
          (set! res (add1 res)))
        (dfs neighbor))))

  (dfs 0)
  res)