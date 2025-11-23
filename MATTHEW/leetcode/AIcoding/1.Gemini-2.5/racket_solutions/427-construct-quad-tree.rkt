(define-struct node (val isLeaf topLeft topRight bottomLeft bottomRight))

(define (construct grid)
  (define (all-same? r-start c-start size)
    (let* ((first-val (list-ref (list-ref grid r-start) c-start)))
      (for/and ((r (in-range r-start (+ r-start size)))
                (c (in-range c-start (+ c-start size))))
        (= (list-ref (list-ref grid r) c) first-val))))

  (define (build-quad-tree r-start c-start size)
    (if (all-same? r-start c-start size)
        (node (= (list-ref (list-ref grid r-start) c-start) 1)
              #t
              #f #f #f #f)
        (let* ((half-size (/ size 2))
               (topLeft (build-quad-tree r-start c-start half-size))
               (topRight (build-quad-tree r-start (+ c-start half-size) half-size))
               (bottomLeft (build-quad-tree (+ r-start half-size) c-start half-size))
               (bottomRight (build-quad-tree (+ r-start half-size) (+ c-start half-size) half-size)))
          (node #f
                #f
                topLeft topRight bottomLeft bottomRight))))

  (build-quad-tree 0 0 (length grid)))