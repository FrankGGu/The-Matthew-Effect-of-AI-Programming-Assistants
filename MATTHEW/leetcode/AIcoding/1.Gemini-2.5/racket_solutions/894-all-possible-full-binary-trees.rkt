(define-struct TreeNode (val left right) #:transparent)

(define memo (make-hash))

(define (all-possible-fbt n)
  (cond
    [(hash-has-key? memo n)
     (hash-ref memo n)]
    [(even? n)
     (hash-set! memo n '())
     '()]
    [(= n 1)
     (let ((result (list (TreeNode 0 #f #f))))
       (hash-set! memo n result)
       result)]
    [else
     (let ((all-sub-trees
            (for/list ((i (in-range 1 n 2)))
              (let* ((left-trees (all-possible-fbt i))
                     (right-trees (all-possible-fbt (- n 1 i))))
                (for*/list ((l left-trees)
                            (r right-trees))
                  (TreeNode 0 l r))))))
       (let ((final-result (apply append all-sub-trees)))
         (hash-set! memo n final-result)
         final-result))]))