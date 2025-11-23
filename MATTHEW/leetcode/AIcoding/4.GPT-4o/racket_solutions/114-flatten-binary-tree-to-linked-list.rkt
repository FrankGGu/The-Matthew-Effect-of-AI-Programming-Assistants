(define (flatten tree)
  (define (helper node)
    (when node
      (let ((left (car node))
            (right (cadr node)))
        (set-cdr! node right)
        (set-car! node left)
        (helper left)
        (helper right)))))

(flatten tree)