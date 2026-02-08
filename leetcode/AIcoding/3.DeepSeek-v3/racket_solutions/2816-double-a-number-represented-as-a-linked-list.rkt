(define/contract (double-it head)
  (-> (or/c list-node? #f) (or/c list-node? #f))
  (define (reverse-list node)
    (let loop ([prev #f] [curr node])
      (if (not curr)
          prev
          (let ([next (list-node-next curr)])
            (set-list-node-next! curr prev)
            (loop curr next)))))
  (define (add-one node)
    (let loop ([carry 1] [node node] [prev #f])
      (if (and (not node) (zero? carry))
          #f
          (let* ([val (if node (list-node-val node) 0)]
                 [sum (+ val carry)]
                 [new-val (modulo sum 10)]
                 [new-carry (quotient sum 10)]
                 [new-node (make-list-node new-val #f)])
            (when prev (set-list-node-next! prev new-node))
            (loop new-carry (and node (list-node-next node)) new-node)
            new-node))))
  (define reversed (reverse-list head))
  (define doubled
    (let loop ([carry 0] [node reversed] [prev #f])
      (if (and (not node) (zero? carry))
          #f
          (let* ([val (if node (list-node-val node) 0)]
                 [sum (+ val val carry)]
                 [new-val (modulo sum 10)]
                 [new-carry (quotient sum 10)]
                 [new-node (make-list-node new-val #f)])
            (when prev (set-list-node-next! prev new-node))
            (loop new-carry (and node (list-node-next node)) new-node)
            new-node))))
  (define result (reverse-list doubled))
  (if (and result (zero? (list-node-val result)))
      (list-node-next result)
      result))