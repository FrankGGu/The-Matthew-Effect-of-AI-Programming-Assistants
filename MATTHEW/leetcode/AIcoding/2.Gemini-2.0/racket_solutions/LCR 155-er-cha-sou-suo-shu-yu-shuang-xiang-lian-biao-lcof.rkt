(define (treeToDoublyList root)
  (define (inorder-traversal node acc)
    (cond
      [(null? node) acc]
      [else
       (let* ([left-result (inorder-traversal (bst-node-left node) acc)]
              [current-result (if (null? left-result)
                                  (cons node '())
                                  (let ([last-node (car (cdr left-result))])
                                    (set-bst-node-right! last-node node)
                                    (set-bst-node-left! node last-node)
                                    left-result))]
              [right-result (inorder-traversal (bst-node-right node) current-result)])
         (cond
           [(null? right-result)
            (if (null? current-result)
                (cons node (cons node '()))
                (let ([first-node (car current-result)])
                  (cons first-node (cons node '()))))]
           [else
            (let* ([first-node (car current-result)]
                   [last-node (car (cdr right-result))])
              (set-bst-node-right! node (car right-result))
              (set-bst-node-left! (car right-result) node)
              (cons first-node (cons last-node '()))))]))]))

  (if (null? root)
      root
      (let ([result (inorder-traversal root '())])
        (let ([first-node (car result)]
              [last-node (car (cdr result))])
          (set-bst-node-right! last-node first-node)
          (set-bst-node-left! first-node last-node)
          first-node))))