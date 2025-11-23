(define (preorder root)
  (let loop ([node root] [res '()])
    (if (null? node)
        res
        (let ([children (node-children node)])
          (loop (car children) 
                (foldl loop (cons (node-val node) res) (cdr children))))))