(define (check-tree root)
  (cond
    [(null? root) #t]
    [(and (null? (cdr root)) (null? (cddr root))) #t]
    [else (= (car root) (+ (car (cdr root)) (car (cddr root))))]))