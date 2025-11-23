#lang racket

(struct tree-node (val left right) #:mutable)

(define (recover-from-preorder s)
  (let ([parsed-nodes (parse-s s)])
    (if (null? parsed-nodes)
        #f ; Empty string, no tree
        (let ([stack '()] ; Stack stores (list depth tree-node)
              [root #f])
          (for-each (lambda (node-pair)
                      (let* ([current-depth (car node-pair)]
                             [current-val (cdr node-pair)]
                             [new-node (make-tree-node current-val #f #f)])

                        (when (null? root)
                          (set! root new-node))

                        ;; Pop nodes from stack whose depth is >= current-depth.
                        ;; This means we are moving up the tree to find the parent
                        ;; of the current node, or a suitable sibling's parent.
                        (let loop ()
                          (when (and (not (null? stack))
                                     (>= (car (car stack)) current-depth))
                            (set! stack (cdr stack))
                            (loop)))

                        ;; If stack is not empty, the top element's node is the parent
                        ;; of the current new-node.
                        (when (not (null? stack))
                          (let* ([parent-info (car stack)]
                                 [parent-node (cadr parent-info)])
                            ;; Attach new-node as left or right child of parent-node.
                            ;; According to problem, if a node has only one child, it must be a left child.
                            ;; So, we always try to fill left first.
                            (if (not (tree-node-left parent-node))
                                (set-tree-node-left! parent-node new-node)
                                (set-tree-node-right! parent-node new-node))))

                        ;; Push current node onto stack with its depth
                        (set! stack (cons (list current-depth new-node) stack))))
                    parsed-nodes)
          root))))

(define (parse-s s)
  (let ([len (string-length s)])
    (define (parse-helper current-idx)
      (if (>= current-idx len)
          '()
          (let-values ([(depth next-idx-after-dashes)
                        (let loop ([idx current-idx] [dashes 0])
                          (if (and (< idx len) (char=? (string-ref s idx) #\-))
                              (loop (+ idx 1) (+ dashes 1))
                              (values dashes idx)))])
            (let-values ([(num next-idx-after-num)
                          (let loop ([idx next-idx-after-dashes] [num-chars '()])
                            (if (and (< idx len) (char-numeric? (string-ref s idx)))
                                (loop (+ idx 1) (cons (string-ref s idx) num-chars))
                                (values (string->number (list->string (reverse num-chars))) idx)))])
              (cons (cons depth num) (parse-helper next-idx-after-num))))))
    (parse-helper 0)))