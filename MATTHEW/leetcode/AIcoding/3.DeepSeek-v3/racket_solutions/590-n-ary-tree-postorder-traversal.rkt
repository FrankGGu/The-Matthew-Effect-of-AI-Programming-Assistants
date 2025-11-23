(define (postorder root)
  (let loop ([node root] [res '()])
    (if (null? node)
        res
        (let ([children (node-children node)])
          (loop (if (null? children) null (car children))
                (foldl loop (cons (node-val node) res) (if (null? children) '() (cdr children))))))))