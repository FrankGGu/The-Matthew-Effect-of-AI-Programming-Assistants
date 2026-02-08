(define (sumOfLeftLeaves root)
  (define (is-leaf? node)
    (and node (null? (left node)) (null? (right node))))

  (define (helper node is-left)
    (cond
      [(null? node) 0]
      [(and is-left (is-leaf? node)) (val node)]
      [else (+ (helper (left node) #t) (helper (right node) #f))]))

  (helper root #f))