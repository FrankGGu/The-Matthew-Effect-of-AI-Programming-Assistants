(define (delete-node node)
  (cond
    [(null? node) (void)]
    [(null? (cdr node)) (void)]
    [else
     (begin
       (set! (car node) (car (cdr node)))
       (set-cdr! node (cdr (cdr node))))]))