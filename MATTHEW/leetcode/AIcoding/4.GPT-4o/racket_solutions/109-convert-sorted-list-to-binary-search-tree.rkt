(define-type ListNode
  (struct ListNode (val next)))

(define-type TreeNode
  (struct TreeNode (val left right)))

(define (sorted-list-to-bst head)
  (define (to-list node)
    (if (null? node)
        '()
        (cons (ListNode-val node) (to-list (ListNode-next node)))))

  (define (build-bst lst)
    (if (null? lst)
        #f
        (let* ((mid (floor (/ (length lst) 2)))
               (left (take lst mid))
               (root-val (list-ref lst mid))
               (right (drop lst (+ mid 1))))
          (TreeNode root-val (build-bst left) (build-bst right)))))

  (build-bst (to-list head)))

(define (take lst n)
  (if (or (null? lst) (zero? n))
      '()
      (cons (car lst) (take (cdr lst) (- n 1)))))

(define (drop lst n)
  (if (or (null? lst) (zero? n))
      lst
      (drop (cdr lst) (- n 1))))