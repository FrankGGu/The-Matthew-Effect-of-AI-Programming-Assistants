(define/contract (path-sum root targetSum)
  (-> (or/c #f (tree-node/c exact-integer?)) exact-integer? exact-integer?)
  (define (helper node prefix-sum sum-count)
    (if (not node)
        sum-count
        (let* ([current-sum (+ (tree-node-val node) (car prefix-sum))]
               [required (- current-sum targetSum)]
               [new-count (+ sum-count (hash-ref prefix-sum required 0))]
          (helper (tree-node-left node)
                  (cons current-sum (hash-set (cdr prefix-sum) current-sum (add1 (hash-ref (cdr prefix-sum) current-sum 0))))
                  (helper (tree-node-right node)
                          (cons current-sum (hash-set (cdr prefix-sum) current-sum (add1 (hash-ref (cdr prefix-sum) current-sum 0))))
                          new-count)))))
  (if (not root)
      0
      (helper root (cons 0 (hash 0 1)) 0)))