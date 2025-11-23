(define (isSameTree p q)
  (cond
    [(and (null? p) (null? q)) #t]
    [(or (null? p) (null? q)) #f]
    [(= (tree-val p) (tree-val q)) 
     (and (isSameTree (tree-left p) (tree-left q))
          (isSameTree (tree-right p) (tree-right q))]
    [else #f]))

(define (tree-val tree)
  (if (null? tree) 0 (car tree)))

(define (tree-left tree)
  (if (null? tree) null (cadr tree)))

(define (tree-right tree)
  (if (null? tree) null (caddr tree)))