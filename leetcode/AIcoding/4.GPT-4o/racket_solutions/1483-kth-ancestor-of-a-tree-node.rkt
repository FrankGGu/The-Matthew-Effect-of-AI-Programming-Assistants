(define Node
  (lambda (val left right)
    (list val left right)))

(define (get-kth-ancestor root k node)
  (define (dfs current depth)
    (if (null? current)
        #f
        (begin
          (if (= (car current) node)
              (if (>= depth k)
                  (list current)
                  #f)
              (let* ((left (dfs (cadr current) (add1 depth)))
                     (right (dfs (caddr current) (add1 depth)))
                     (found (or left right)))
                (if found
                    (if (>= depth k)
                        (if (null? left)
                            (car found)
                            (if (null? right)
                                (car found)
                                (if (and (= (cadr left) (cadr right))
                                         (= (caddr left) (caddr right)))
                                    (car found)
                                    (if (>= (add1 depth) k)
                                        (car found)
                                        #f)))
                            (if (>= (add1 depth) k)
                                (car found)
                                #f))
                    #f)))))
  (define result (dfs root 0))
  (if result
      (car result)
      #f))

(define KthAncestor
  (lambda (node)
    (define (init)
      (define ancestors (make-vector 1000 #f))
      (define (set-ancestors current parent depth)
        (if (null? current)
            #f
            (begin
              (vector-set! ancestors (car current) parent)
              (set-ancestors (cadr current) (car current) (add1 depth))
              (set-ancestors (caddr current) (car current) (add1 depth))))
      (set-ancestors node #f 0)
      ancestors)
    (define ancestors (init))
    (lambda (k)
      (let loop ((node (vector-ref ancestors node)) (k k))
        (if (or (null? node) (= k 0))
            node
            (loop (vector-ref ancestors node) (sub1 k)))))))

(define (create-tree)
  (Node 1 (Node 2 (Node 4 #f #f) (Node 5 #f #f)) (Node 3 (Node 6 #f #f) (Node 7 #f #f))))

(define root (create-tree))
(define kth-ancestor (KthAncestor root))

(kth-ancestor 1) ; should return 1
(kth-ancestor 2) ; should return 2
(kth-ancestor 3) ; should return 1
(kth-ancestor 4) ; should return #f