(define (create-binary-tree descriptions)
  (define nodes (make-hash))
  (define roots (make-hash))

  (for ([desc descriptions])
    (define parent (car desc))
    (define child (cadr desc))
    (define is-left (caddr desc))

    (unless (hash-has-key? nodes parent)
      (hash-set! nodes parent (cons parent #f)))
    (unless (hash-has-key? nodes child)
      (hash-set! nodes child (cons child #f)))

    (define parent-node (hash-ref nodes parent))
    (define child-node (hash-ref nodes child))

    (if is-left
        (set-cdr! parent-node (cons (car child-node) (cdr parent-node))))
    (set-cdr! parent-node (cons (car child-node) (cdr parent-node)))

    (hash-set! nodes parent parent-node)
    (hash-set! nodes child child-node)

    (hash-set! roots child #t))

  (define root-val #f)
  (hash-for-each nodes
                 (lambda (key val)
                   (unless (hash-has-key? roots key)
                     (set! root-val key))))

  (define (build-tree val)
    (if (not (hash-has-key? nodes val))
        #f
        (let* ([node-data (hash-ref nodes val)]
               [left-child (if (cddr node-data) (build-tree (car (cddr node-data))) #f)]
               [right-child (if (and (cddr node-data) (cdddr node-data)) (build-tree (car (cdddr node-data))) #f)])
          (list val left-child right-child))))

  (build-tree root-val))