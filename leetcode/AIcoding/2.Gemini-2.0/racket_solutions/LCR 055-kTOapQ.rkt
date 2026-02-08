(define (bst-iterator root)
  (define stack '())
  (define (push-left node)
    (when node
      (set! stack (cons node stack))
      (push-left (->left node))))

  (push-left root)

  (define (next)
    (define top (car stack))
    (set! stack (cdr stack))
    (push-left (->right top))
    (->val top))

  (define (has-next?)
    (not (null? stack)))

  (struct bst-iterator-struct (next has-next?))
  (bst-iterator-struct next has-next?))