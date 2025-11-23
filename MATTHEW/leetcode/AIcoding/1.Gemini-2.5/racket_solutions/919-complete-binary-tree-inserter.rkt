#lang racket

(provide (struct-out TreeNode)
         (struct-out CBTInserter)
         CBTInserter-init
         CBTInserter-insert
         CBTInserter-get-root)

(define-struct (TreeNode val [left #:mutable] [right #:mutable]))

(define-struct (CBTInserter [root #:mutable] [queue #:mutable])) ; queue stores nodes that can accept children

(define (CBTInserter-init root-node)
  (let ([bfs-q (list root-node)]) ; BFS queue for initial traversal
    (let ([inserter-q (list)])    ; CBTInserter's internal queue for potential parents

      (let loop ([current-bfs-q bfs-q])
        (unless (empty? current-bfs-q)
          (let ([curr (car current-bfs-q)])
            (let ([next-bfs-q (cdr current-bfs-q)])
              ;; If current node has an empty slot, add it to inserter-q
              (when (or (not (TreeNode-left curr)) (not (TreeNode-right curr)))
                (set! inserter-q (append inserter-q (list curr))))

              ;; Add children to BFS queue for traversal
              (when (TreeNode-left curr)
                (set! next-bfs-q (append next-bfs-q (list (TreeNode-left curr)))))
              (when (TreeNode-right curr)
                (set! next-bfs-q (append next-bfs-q (list (TreeNode-right curr)))))
              (loop next-bfs-q))))))
    (CBTInserter root-node inserter-q)))

(define (CBTInserter-insert inserter val)
  (let ([new-node (TreeNode val #f #f)])
    (let ([parent-node (car (CBTInserter-queue inserter))]) ; Get the first node from the queue
      (let ([parent-val (TreeNode-val parent-node)]) ; Store parent's value to return later

        ;; Attach new-node to parent-node
        (if (not (TreeNode-left parent-node))
            (set-TreeNode-left! parent-node new-node)
            (set-TreeNode-right! parent-node new-node))

        ;; Add new-node to the end of the inserter's queue
        (set-CBTInserter-queue! inserter (append (CBTInserter-queue inserter) (list new-node)))

        ;; If parent-node is now full, remove it from the front of the queue
        (when (and (TreeNode-left parent-node) (TreeNode-right parent-node))
          (set-CBTInserter-queue! inserter (cdr (CBTInserter-queue inserter))))

        parent-val)))) ; Return the value of the parent

(define (CBTInserter-get-root inserter)
  (CBTInserter-root inserter))