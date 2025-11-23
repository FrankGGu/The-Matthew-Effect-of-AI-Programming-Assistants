#lang racket

(define (closest-nodes root queries)
  (define (inorder-traversal node)
    (if (not node)
        '()
        (append (inorder-traversal (node-left node))
                (list (node-val node))
                (inorder-traversal (node-right node)))))

  (define sorted-values (inorder-traversal root))

  (define (find-closest val)
    (let loop ((left 0) (right (sub1 (length sorted-values))))
      (cond ((> left right) (list (if (> left (sub1 (length sorted-values))) #f (list-ref sorted-values left)) (if (< right 0) #f (list-ref sorted-values right))))
            (else
             (let ((mid (quotient (+ left right) 2)))
               (cond ((= (list-ref sorted-values mid) val) (list val val))
                     ((< val (list-ref sorted-values mid))
                      (loop left (sub1 mid)))
                     (else
                      (loop (add1 mid) right))))))))

  (map find-closest queries))