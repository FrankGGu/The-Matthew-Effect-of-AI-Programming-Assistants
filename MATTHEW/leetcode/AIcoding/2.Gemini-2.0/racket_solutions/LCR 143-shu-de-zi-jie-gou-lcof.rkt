(define (is-subtree s t)
  (cond
    [(null? t) #t]
    [(null? s) #f]
    [else (or (equal-tree s t)
              (is-subtree (tree-left s) t)
              (is-subtree (tree-right s) t))]))

(define (equal-tree s t)
  (cond
    [(and (null? s) (null? t)) #t]
    [(or (null? s) (null? t)) #f]
    [(not (equal? (tree-val s) (tree-val t))) #f]
    [else (and (equal-tree (tree-left s) (tree-left t))
                (equal-tree (tree-right s) (tree-right t)))]))

(provide is-subtree)