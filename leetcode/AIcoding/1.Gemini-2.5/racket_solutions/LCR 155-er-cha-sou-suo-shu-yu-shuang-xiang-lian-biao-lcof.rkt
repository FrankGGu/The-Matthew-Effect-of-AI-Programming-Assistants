(struct Node (val left right) #:mutable)

(define (tree-to-list root)
  (define head #f)
  (define prev #f)

  (define (inorder node)
    (when node
      (inorder (Node-left node))

      (when prev
        (set-Node-right! prev node)
        (set-Node-left! node prev))
      (unless head
        (set! head node))
      (set! prev node)

      (inorder (Node-right node))))

  (when root
    (inorder root)
    (set-Node-right! prev head)
    (set-Node-left! head prev))

  head)