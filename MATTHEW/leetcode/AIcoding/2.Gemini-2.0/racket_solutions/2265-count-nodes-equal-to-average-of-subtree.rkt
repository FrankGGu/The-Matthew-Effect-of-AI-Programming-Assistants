(define (average-of-subtree root)
  (define (helper node)
    (cond
      [(null? node) (values 0 0)]
      [else
       (define-values (left-sum left-count) (helper (->left node)))
       (define-values (right-sum right-count) (helper (->right node)))
       (values (+ (->val node) left-sum right-sum)
               (+ 1 left-count right-count))]))

  (define (count-equal root)
    (cond
      [(null? root) 0]
      [else
       (define-values (sum count) (helper root))
       (+ (if (= (quotient sum count) (->val root)) 1 0)
          (count-equal (->left root))
          (count-equal (->right root)))]))

  (count-equal root))