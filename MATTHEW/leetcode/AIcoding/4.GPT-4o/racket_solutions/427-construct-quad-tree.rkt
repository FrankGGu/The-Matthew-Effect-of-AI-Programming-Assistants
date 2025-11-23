(define struct-quad-tree-node
  (make-struct (val isLeaf topLeft topRight bottomLeft bottomRight)))
(define (construct quadTree)
  (if (null? quadTree)
      #f
      (let* ([n (length quadTree)]
             [total-pixels (* n n)]
             [is-leaf? (and (<= total-pixels 1) (equal? (car quadTree) 0))])
             [root (make-struct-quad-tree-node (if is-leaf? 0 1) is-leaf? #f #f #f #f)])
        (if is-leaf?
            root
            (let* ([half (/ n 2)]
                   [top-left (map (lambda (row) (subvec row 0 half)) (subvec quadTree 0 half))]
                   [top-right (map (lambda (row) (subvec row half)) (subvec quadTree 0 half))]
                   [bottom-left (map (lambda (row) (subvec row 0 half)) (subvec quadTree half))]
                   [bottom-right (map (lambda (row) (subvec row half)) (subvec quadTree half))])
              (set-topLeft! root (construct top-left))
              (set-topRight! root (construct top-right))
              (set-bottomLeft! root (construct bottom-left))
              (set-bottomRight! root (construct bottom-right))
              root))))))

(define (construct-quad-tree grid)
  (construct grid))