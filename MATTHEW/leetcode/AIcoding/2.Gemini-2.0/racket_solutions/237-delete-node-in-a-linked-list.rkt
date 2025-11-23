(define (delete-node node)
  (set! (car node) (car (cdr node)))
  (set-cdr! node (cdr (cdr node))))