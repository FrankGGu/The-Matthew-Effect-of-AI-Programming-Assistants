(define-struct TreeNode (val left right))

(define (construct-from-prepost preorder postorder)
  (cond
    [(empty? preorder) null]
    [(empty? (cdr preorder)) (make-TreeNode (car preorder) null null)]
    [else
     (define root-val (car preorder))
     (define left-root-val (cadr preorder))

     (define (find-index val lst)
       (let loop ([lst lst] [idx 0])
         (cond
           [(empty? lst) -1]
           [(= (car lst) val) idx]
           [else (loop (cdr lst) (+ idx 1))])))

     (define left-root-post-idx (find-index left-root-val postorder))
     (define left-subtree-size (+ left-root-post-idx 1))

     (define left-preorder (take (cdr preorder) left-subtree-size))
     (define left-postorder (take postorder left-subtree-size))

     (define right-preorder (drop (cdr preorder) left-subtree-size))
     (define right-postorder (drop (take postorder (- (length postorder) 1)) left-subtree-size))

     (define left-node (construct-from-prepost left-preorder left-postorder))
     (define right-node (construct-from-prepost right-preorder right-postorder))

     (make-TreeNode root-val left-node right-node)]))