(define/contract (sorted-list-to-bst head)
  (-> (or/c list-node? #f) (or/c tree-node? #f))
  (define (list->vec head)
    (let loop ([head head] [vec '()])
      (if (not head) 
          (list->vector (reverse vec))
          (loop (list-node-next head) (cons (list-node-val head) vec)))))
  (define (build-bst vec left right)
    (if (> left right)
        #f
        (let* ([mid (quotient (+ left right) 2)]
               [root (tree-node (vector-ref vec mid))]
               [left-node (build-bst vec left (sub1 mid))]
               [right-node (build-bst vec (add1 mid) right)])
          (set-tree-node-left! root left-node)
          (set-tree-node-right! root right-node)
          root)))
  (let ([vec (list->vec head)])
    (if (zero? (vector-length vec))
        #f
        (build-bst vec 0 (sub1 (vector-length vec))))))