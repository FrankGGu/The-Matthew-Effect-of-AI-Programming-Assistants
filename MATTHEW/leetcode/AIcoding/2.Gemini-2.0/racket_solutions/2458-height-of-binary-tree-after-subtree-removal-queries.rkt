(define (height-of-binary-tree-after-subtree-removal-queries root queries)
  (define (tree-height node)
    (if (null? node)
        -1
        (+ 1 (max (tree-height (car node)) (tree-height (cdr node))))))

  (define (get-nodes node depth node-depths)
    (if (null? node)
        node-depths
        (begin
          (hash-set! node-depths node depth)
          (get-nodes (car node) (+ depth 1) node-depths)
          (get-nodes (cdr node) (+ depth 1) node-depths))))

  (define (build-depths-map root)
    (get-nodes root 0 (make-hash)))

  (define (calculate-heights root)
    (define node-depths (build-depths-map root))

    (define (get-heights node)
      (if (null? node)
          (values '() '())
          (let* ((left-node (car node))
                 (right-node (cdr node))
                 (left-heights (get-heights left-node))
                 (right-heights (get-heights right-node))
                 (left-max (if (null? (car left-heights)) -1 (apply max (car left-heights))))
                 (right-max (if (null? (car right-heights)) -1 (apply max (car right-heights))))
                 (current-height (+ 1 (max left-max right-max))))
            (values (cons current-height (car left-heights) (car right-heights))
                    (cons node (cdr left-heights) (cdr right-heights))))))

    (get-heights root))

  (define (remove-subtree root node)
    (define (remove-node current-node)
      (cond
        [(null? current-node) current-node]
        [(equal? current-node node) null]
        [else (cons (remove-node (car current-node)) (remove-node (cdr current-node)))]))
    (remove-node root))

  (map (lambda (query)
         (tree-height (remove-subtree root query)))
       queries))