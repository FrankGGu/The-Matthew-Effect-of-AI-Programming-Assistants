(define-struct tree (val left right))

(define (isSubStructure A B)
  (if (and (not A) (not B))
      #f
      (and (A (val) = (B (val)))
           (isSameStructure A B)
           (or (isSubStructure (tree-left A) B)
               (isSubStructure (tree-right A) B)))))

(define (isSameStructure A B)
  (if (not B)
      #t
      (if (not A)
          #f
          (and (= (tree-val A) (tree-val B))
               (isSameStructure (tree-left A) (tree-left B))
               (isSameStructure (tree-right A) (tree-right B))))))

(define (isSubStructure A B)
  (if (not B)
      #f
      (or (isSameStructure A B)
          (isSubStructure (tree-left A) B)
          (isSubStructure (tree-right A) B))))