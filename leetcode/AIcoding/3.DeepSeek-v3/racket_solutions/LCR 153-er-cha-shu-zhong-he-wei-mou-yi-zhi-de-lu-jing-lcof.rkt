(define/contract (path-sum root targetSum)
  (-> (or/c null? tree-node?) exact-integer? (listof (listof exact-integer?)))
  (define res '())
  (define (dfs node path sum)
    (if (null? node)
        (void)
        (let* ([val (tree-node-val node)]
               [new-sum (+ sum val)]
               [new-path (cons val path)]
               [left (tree-node-left node)]
               [right (tree-node-right node)])
          (if (and (null? left) (null? right) (= new-sum targetSum))
              (set! res (cons (reverse new-path) res))
              (begin
                (dfs left new-path new-sum)
                (dfs right new-path new-sum))))))
  (dfs root '() 0)
  res)