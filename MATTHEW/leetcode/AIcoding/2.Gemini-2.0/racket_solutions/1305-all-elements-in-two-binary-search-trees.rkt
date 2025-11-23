(define (get-all-elements root1 root2)
  (define (inorder root)
    (if (null? root)
        '()
        (append (inorder (car root))
                (list (cadr root))
                (inorder (caddr root)))))

  (define (merge-sorted list1 list2)
    (cond
      [(null? list1) list2]
      [(null? list2) list1]
      [(<= (car list1) (car list2))
       (cons (car list1) (merge-sorted (cdr list1) list2))]
      [else
       (cons (car list2) (merge-sorted list1 (cdr list2)))]))

  (merge-sorted (inorder root1) (inorder root2)))