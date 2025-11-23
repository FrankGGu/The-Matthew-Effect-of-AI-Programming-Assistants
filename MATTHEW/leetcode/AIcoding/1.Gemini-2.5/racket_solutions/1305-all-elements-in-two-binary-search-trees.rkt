(define (inorder-traversal node)
  (if (null? node)
      '()
      (append (inorder-traversal (TreeNode-left node))
              (list (TreeNode-val node))
              (inorder-traversal (TreeNode-right node)))))

(define (merge-sorted-lists lst1 lst2)
  (cond
    ((null? lst1) lst2)
    ((null? lst2) lst1)
    ((<= (car lst1) (car lst2))
     (cons (car lst1) (merge-sorted-lists (cdr lst1) lst2)))
    (else
     (cons (car lst2) (merge-sorted-lists lst1 (cdr lst2))))))

(define (get-all-elements root1 root2)
  (let* ((list1 (inorder-traversal root1))
         (list2 (inorder-traversal root2)))
    (merge-sorted-lists list1 list2)))