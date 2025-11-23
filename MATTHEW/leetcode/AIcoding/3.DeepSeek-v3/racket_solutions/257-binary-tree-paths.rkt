(define/contract (binary-tree-paths root)
  (-> (or/c null? tree-node?) (listof string?))
  (define (helper node path res)
    (if (null? node)
        res
        (let* ([new-path (if (null? path) 
                             (number->string (tree-node-val node)) 
                             (string-append path "->" (number->string (tree-node-val node))))]
               [left (tree-node-left node)]
               [right (tree-node-right node)])
          (if (and (null? left) (null? right))
              (cons new-path res)
              (helper right new-path (helper left new-path res))))))
  (if (null? root)
      '()
      (helper root "" '())))

(define (tree-node? x)
  (and (not (null? x))
       (hash? x)
       (hash-has-key? x 'val)
       (hash-has-key? x 'left)
       (hash-has-key? x 'right)))

(define (tree-node-val node) (hash-ref node 'val))
(define (tree-node-left node) (hash-ref node 'left))
(define (tree-node-right node) (hash-ref node 'right))