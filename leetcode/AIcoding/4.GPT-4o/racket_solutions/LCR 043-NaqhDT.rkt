(define class TreeNode
  (class object%
    (super-new)
    (init x)
    (define/public (get-val) x)
    (define/public (set-val val) (set! x val))
    (define/public (left) '())
    (define/public (set-left left-node) (set! left left-node))
    (define/public (right) '())
    (define/public (set-right right-node) (set! right right-node))
    (define/public (to-string) (format "~a" x))
    ))

(define class CBTInserter
  (class object%
    (super-new)
    (define/public (init root)
      (set! this-root root)
      (set! this-tree '())
      (set! this-index 0)
      (define (traverse node)
        (when node
          (set! this-tree (cons node this-tree))
          (traverse (send node left))
          (traverse (send node right))))
      (traverse root))
    (define/public (insert v)
      (define new-node (new TreeNode v))
      (define parent (list-ref this-tree (quotient (- this-index 1) 2)))
      (if (even? this-index)
          (send parent set-left new-node)
          (send parent set-right new-node))
      (set! this-index (+ this-index 1))
      (send new-node get-val))
    (define/public (get-root)
      this-root))

  (define this-root '())
  (define this-tree '())
  (define this-index 0))

(define (create-inserter root)
  (new CBTInserter (list->tree-node root)))

(define (insert-tree inserter v)
  (send inserter insert v))

(define (get-root inserter)
  (send inserter get-root))