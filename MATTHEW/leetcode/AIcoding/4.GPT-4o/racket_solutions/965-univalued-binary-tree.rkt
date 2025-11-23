(define (isUnivalTree root)
  (define (helper node val)
    (if (null? node)
        #t
        (and (= (tree-val node) val)
             (helper (left node) val)
             (helper (right node) val))))
  (if (null? root)
      #t
      (helper root (tree-val root))))