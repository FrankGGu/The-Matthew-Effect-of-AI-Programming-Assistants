(define (searchBST root val)
  (cond
    [(null? root) #f]
    [(= (root-value root) val) root]
    [(< val (root-value root)) (searchBST (root-left root) val)]
    [else (searchBST (root-right root) val)]))

(define (root-value node) (car node))
(define (root-left node) (cadr node))
(define (root-right node) (caddr node))