(define (merge-trees t1 t2)
  (cond
    [(and (null? t1) (null? t2)) null]
    [(null? t1) t2]
    [(null? t2) t1]
    [else
     (cons (+ (car t1) (car t2))
           (cons (merge-trees (cadr t1) (cadr t2))
                 (merge-trees (caddr t1) (caddr t2))))]))