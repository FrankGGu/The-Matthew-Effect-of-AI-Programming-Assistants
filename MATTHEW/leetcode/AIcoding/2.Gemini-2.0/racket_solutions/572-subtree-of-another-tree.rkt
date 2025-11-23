(define (is-same-tree? p q)
  (cond
    [(and (null? p) (null? q)) #t]
    [(or (null? p) (null? q)) #f]
    [(not (= (car p) (car q))) #f]
    [else (and (is-same-tree? (cadr p) (cadr q))
               (is-same-tree? (caddr p) (caddr q)))]))

(define (is-subtree? root subroot)
  (cond
    [(null? root) #f]
    [(is-same-tree? root subroot) #t]
    [else (or (is-subtree? (cadr root) subroot)
               (is-subtree? (caddr root) subroot))]))