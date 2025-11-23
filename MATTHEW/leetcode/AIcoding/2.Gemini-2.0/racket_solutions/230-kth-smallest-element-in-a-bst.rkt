(define (kth-smallest root k)
  (define (inorder root acc)
    (cond
      [(null? root) acc]
      [else (let* ([left-acc (inorder (bst-node-left root) acc)]
                    [current-acc (cons (bst-node-val root) left-acc)]
                    [right-acc (inorder (bst-node-right root) current-acc)])
              right-acc)]))
  (list-ref (sort (inorder root '()) <) (- k 1)))