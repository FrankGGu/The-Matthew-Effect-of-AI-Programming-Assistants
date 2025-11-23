(define (is-balanced? root)
  (define (height node)
    (if (null? node)
        0
        (+ 1 (max (height (car node)) (height (cdr node))))))

  (define (is-balanced-helper node)
    (cond
      [(null? node) #t]
      [else
       (let ((left-height (height (car node)))
             (right-height (height (cdr node))))
         (and (<= (abs (- left-height right-height)) 1)
              (is-balanced-helper (car node))
              (is-balanced-helper (cdr node))))]))

  (is-balanced-helper root))