(define/contract (path-sum root targetSum)
  (-> (or/c #f (tree-node/c exact-integer?)) exact-integer? exact-integer?)
  (define (helper node prefix-sum sum-count)
    (if (not node)
        sum-count
        (let* ([current-sum (+ (tree-node-val node) (car prefix-sum))]
               [required (- current-sum targetSum)]
               [new-count (+ sum-count (hash-ref sum-count required 0))]
               [new-prefix (cons current-sum (hash-set (cdr prefix-sum) current-sum (add1 (hash-ref (cdr prefix-sum) current-sum 0)))))]
               [left-count (helper (tree-node-left node) new-prefix new-count)]
               [right-count (helper (tree-node-right node) new-prefix left-count)]
               [updated-prefix (cons current-sum (hash-update (cdr prefix-sum) current-sum sub1))])
          (helper (tree-node-right node) updated-prefix right-count))))
  (helper root (cons 0 (hash 0 1)) 0))