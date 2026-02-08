(define (insert-into-bst root val)
  (cond
    [(null? root) (list 'Node val null null)]
    [(< val (car (cdr root))) (list 'Node (car (cdr root)) (insert-into-bst (car (cdr (cdr root))) val) (car (cdr (cdr (cdr root)))))]
    [else (list 'Node (car (cdr root)) (car (cdr (cdr root))) (insert-into-bst (car (cdr (cdr (cdr root)))) val))]))