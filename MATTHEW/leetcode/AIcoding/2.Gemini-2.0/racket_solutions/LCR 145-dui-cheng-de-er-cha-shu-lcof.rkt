(define (symmetric-tree? root)
  (define (is-mirror? p q)
    (cond
      [(and (null? p) (null? q)) #t]
      [(or (null? p) (null? q)) #f]
      [else (and (= (car p) (car q))
                  (is-mirror? (cdr p) (cddr q))
                  (is-mirror? (cddr p) (cdr q)))]))
  (if (null? root)
      #t
      (is-mirror? (list (car root) (cdr root) (cddr root)) (list (car root) (cdr root) (cddr root)))))