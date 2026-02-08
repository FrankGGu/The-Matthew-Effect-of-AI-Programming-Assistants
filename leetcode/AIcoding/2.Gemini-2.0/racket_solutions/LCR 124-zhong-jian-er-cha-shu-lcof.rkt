(define (buildTree preorder inorder)
  (define (helper pre-start in-start in-end)
    (if (> pre-start (sub1 (length preorder)))
        '()
        (let* ((root-val (list-ref preorder pre-start))
               (root-index (index-of inorder root-val in-start in-end)))
          (cons root-val
                (list (helper (add1 pre-start) in-start (sub1 root-index))
                      (helper (+ pre-start (- root-index in-start) 1) (add1 root-index) in-end)))))))

  (define (index-of lst val start end)
    (let loop ((i start))
      (cond
        [(> i end) #f]
        [(equal? (list-ref lst i) val) i]
        [else (loop (add1 i))])))

  (if (or (null? preorder) (null? inorder))
      '()
      (helper 0 0 (sub1 (length inorder)))))