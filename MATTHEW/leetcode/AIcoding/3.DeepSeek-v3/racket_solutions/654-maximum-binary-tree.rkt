(define/contract (construct-maximum-binary-tree nums)
  (-> (listof exact-integer?) (or/c #f tree-node?))
  (define (build-tree nums)
    (cond
      [(null? nums) #f]
      [else
       (let* ([max-val (apply max nums)]
              [max-idx (index-of nums max-val)]
              [left-nums (take nums max-idx)]
              [right-nums (drop nums (add1 max-idx))])
         (make-tree-node max-val
                         (build-tree left-nums)
                         (build-tree right-nums)))]))
  (build-tree nums))

(define (make-tree-node val left right)
  (let ([node (tree-node val #f #f)])
    (set-tree-node-left! node left)
    (set-tree-node-right! node right)
    node))

(define (index-of lst val)
  (let loop ([lst lst] [idx 0])
    (cond
      [(null? lst) -1]
      [(= (car lst) val) idx]
      [else (loop (cdr lst) (add1 idx))])))