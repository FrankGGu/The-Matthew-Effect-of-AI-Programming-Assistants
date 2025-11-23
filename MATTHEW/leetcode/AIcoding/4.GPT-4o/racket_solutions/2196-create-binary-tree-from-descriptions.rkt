(define (createBinaryTree descriptions)
  (define tree (make-hash))
  (define children (make-hash))

  (for-each (lambda (desc)
              (define parent (first desc))
              (define child (second desc))
              (define isLeft (third desc))
              (hash-set! tree parent (hash 'left #f 'right #f))
              (hash-set! children child parent)
              (if isLeft
                  (hash-set! (hash-ref tree parent) 'left child)
                  (hash-set! (hash-ref tree parent) 'right child)))
            descriptions)

  (define root
    (for/fold ([root #f]) ([node (hash-keys tree)])
      (if (hash-ref children node)
          root
          node)))

  (define (build-tree node)
    (if node
        (let ([children (hash-ref tree node)])
          (cons node
                (cons (build-tree (hash-ref children 'left))
                      (build-tree (hash-ref children 'right))))))
        #f))

  (build-tree root))