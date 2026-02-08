(define (recover-from-preorder traversal)
  (define (helper levels nodes)
    (if (null? nodes) 
      (values '() levels)
      (let* ([level (car nodes)]
             [val (cadr nodes)]
             [next-level (+ level 1)]
             [next-nodes (cddr nodes)]
             [child-nodes (take-while (lambda (x) (equal? (car x) next-level)) next-nodes)])
             [remaining-nodes (drop-while (lambda (x) (equal? (car x) next-level)) next-nodes)])
             [left (if (null? child-nodes) '() (list (list (cadr (car child-nodes)) (car child-nodes))))]
             [right (if (null? (cdr child-nodes)) '() (list (list (cadr (cadr child-nodes)) (car (cadr child-nodes)))))]
             [new-nodes (append left right)])
        (cons (list val (if (null? left) '() (car left)) (if (null? right) '() (car right)))
              (helper next-level remaining-nodes)))))
  (define nodes (map (lambda (x) (list (car x) (cadr x))) (map list (string->list traversal) (map (lambda (x) (if (equal? x #\-) 1 0)) (string->list traversal)))))
  (define start (length (take-while (lambda (x) (equal? (car x) 0)) nodes)))
  (define levels (drop start nodes))
  (define (build-tree n)
    (if (null? n) '()
      (let* ([first (car n)]
             [left (build-tree (cdr n))]
             [right (build-tree (cdr left))])
        (list (car first) left right))))
  (build-tree levels))