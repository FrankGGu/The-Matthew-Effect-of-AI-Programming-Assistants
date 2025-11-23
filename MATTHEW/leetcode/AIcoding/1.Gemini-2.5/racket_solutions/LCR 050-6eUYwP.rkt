(define-struct treenode (val left right))

(define (path-sum root target-sum)
  (cond
    [(null? root) 0]
    [else
     (+ (count-paths-from-node root target-sum 0)
        (path-sum (treenode-left root) target-sum)
        (path-sum (treenode-right root) target-sum))]))

(define (count-paths-from-node node target-sum current-path-sum)
  (cond
    [(null? node) 0]
    [else
     (let ([new-path-sum (+ current-path-sum (treenode-val node))])
       (+ (if (= new-path-sum target-sum) 1 0)
          (count-paths-from-node (treenode-left node) target-sum new-path-sum)
          (count-paths-from-node (treenode-right node) target-sum new-path-sum)))]))