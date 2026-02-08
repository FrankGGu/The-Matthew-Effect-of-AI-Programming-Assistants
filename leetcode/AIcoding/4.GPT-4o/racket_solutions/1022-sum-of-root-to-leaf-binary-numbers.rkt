(define (sum-root-to-leaf binary-tree)
  (define (helper node current)
    (if (null? node)
        0
        (let* ((new-current (+ (* current 2) (car node)))
               (left-sum (helper (cadr node) new-current))
               (right-sum (helper (caddr node) new-current)))
          (if (and (null? (cadr node)) (null? (caddr node)))
              new-current
              (+ left-sum right-sum)))))
  (helper binary-tree 0))