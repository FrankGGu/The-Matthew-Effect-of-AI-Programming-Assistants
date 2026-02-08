(define (buildTree inorder postorder)
  (define (helper inorder-start inorder-end postorder-start postorder-end)
    (if (< inorder-start inorder-end)
        null
        (let* ((root-val (list-ref postorder postorder-end))
               (root-index (index-of root-val inorder inorder-start inorder-end))
               (left-size (- root-index inorder-start)))
          (cons root-val
                (list (helper inorder-start (- root-index 1) postorder-start (+ postorder-start left-size -1))
                      (helper (+ root-index 1) inorder-end (+ postorder-start left-size) (- postorder-end 1)))))))

  (define (index-of val lst start end)
    (let loop ((i start))
      (cond
        ((> i end) #f)
        ((equal? (list-ref lst i) val) i)
        (else (loop (+ i 1))))))

  (helper 0 (- (length inorder) 1) 0 (- (length postorder) 1)))