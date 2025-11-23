(define (evaluateTree root)
  (if (null? root)
      #f
      (case (node-val root)
        ((0) #f)
        ((1) #t)
        ((2) (or (evaluateTree (left-child root)) (evaluateTree (right-child root))))
        ((3) (and (evaluateTree (left-child root)) (evaluateTree (right-child root)))))))

(define (node-val node) (car node))
(define (left-child node) (cadr node))
(define (right-child node) (caddr node))