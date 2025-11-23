(define BSTIterator
  (class object%
    (super-new)
    (init (root))
    (define values '())
    (define index 0)

    (define (inorder node)
      (when node
        (inorder (send node get-left))
        (set! values (append values (list (send node get-val))))
        (inorder (send node get-right))))

    (define/public (next)
      (define val (list-ref values index))
      (set! index (+ index 1))
      val)

    (define/public (hasNext)
      (< index (length values)))

    (define/override (initialize)
      (set! values '())
      (set! index 0)
      (inorder root))))

(define (create-iterator root)
  (new BSTIterator [root root]))