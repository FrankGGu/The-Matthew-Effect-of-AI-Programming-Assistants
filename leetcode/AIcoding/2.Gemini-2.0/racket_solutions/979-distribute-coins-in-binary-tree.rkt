(define (distribute-coins root)
  (define (dfs node)
    (cond [(null? node) (values 0 0)]
          [else
           (define-values (left-move left-coins) (dfs (car node)))
           (define-values (right-move right-coins) (dfs (cdr node)))
           (define move (+ left-move right-move))
           (define coins (+ left-coins right-coins (cadr node) -1))
           (values (+ move (abs coins)) coins)]))
  (define-values (_ ans) (dfs root))
  ans)