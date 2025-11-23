(define (BSTIterator root)
  (define stack '())
  (define (push-left node)
    (when node
      (set! stack (cons node stack))
      (push-left (node-left node))))
  (push-left root)

  (define (next)
    (define top (car stack))
    (set! stack (cdr stack))
    (push-left (node-right top))
    (node-val top))

  (define (hasNext)
    (not (null? stack)))

  (list next hasNext))