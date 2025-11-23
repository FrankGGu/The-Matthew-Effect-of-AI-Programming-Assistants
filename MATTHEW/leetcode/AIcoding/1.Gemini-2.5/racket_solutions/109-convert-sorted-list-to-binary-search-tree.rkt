(define (sorted-list-to-bst head)
  (if (eq? head #f)
      #f
      (let* ((current-list-node-ptr (box head))
             (len (let loop ((node head) (count 0))
                    (if (eq? node #f)
                        count
                        (loop (list-node-next node) (+ count 1))))))

        (define (build-tree num-nodes)
          (if (<= num-nodes 0)
              #f
              (let* ((left-subtree-size (quotient (- num-nodes 1) 2))
                     (left-child (build-tree left-subtree-size))
                     (root-val (list-node-val (unbox current-list-node-ptr)))
                     (_ (set-box! current-list-node-ptr (list-node-next (unbox current-list-node-ptr))))
                     (right-subtree-size (- num-nodes 1 left-subtree-size))
                     (right-child (build-tree right-subtree-size)))
                (tree-node root-val left-child right-child))))

        (build-tree len))))