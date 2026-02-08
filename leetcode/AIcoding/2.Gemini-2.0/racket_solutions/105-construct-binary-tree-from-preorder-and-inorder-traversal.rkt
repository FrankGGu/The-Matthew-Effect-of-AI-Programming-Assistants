(define (buildTree preorder inorder)
  (define (helper pre-start in-start in-end)
    (if (> in-start in-end)
        null
        (let* ((root-val (list-ref preorder pre-start))
               (root-index (index-of inorder root-val in-start in-end))
               (root (cons root-val null)))
          (set-cdr root (cons (helper (+ pre-start 1) in-start (- root-index 1)) null))
          (set-cdr (cdr root) (cons (helper (+ pre-start (- root-index in-start) 1) (+ root-index 1) in-end) null))
          root)))

  (define (index-of lst val start end)
    (cond ((>= start end) (if (equal? (list-ref lst start) val) start #f))
          (else
           (let loop ((i start))
             (cond ((> i end) #f)
                   ((equal? (list-ref lst i) val) i)
                   (else (loop (+ i 1))))))))

  (if (or (null? preorder) (null? inorder))
      null
      (helper 0 0 (- (length inorder) 1))))