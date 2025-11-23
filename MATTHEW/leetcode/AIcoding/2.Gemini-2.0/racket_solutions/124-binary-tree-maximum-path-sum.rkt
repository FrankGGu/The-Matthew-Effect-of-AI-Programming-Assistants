(define (max-path-sum root)
  (define (helper node)
    (cond
      [(null? node) (values 0 -inf.0)]
      [else
       (define-values (left-max-with-root left-max-path) (helper (car node)))
       (define-values (right-max-with-root right-max-path) (helper (cdr node)))
       (define current-max-with-root (max 0 left-max-with-root 0 right-max-with-root))
       (define max-with-root (+ (third node) current-max-with-root))
       (define max-path (max left-max-path right-max-path
                           (+ (third node) left-max-with-root right-max-with-root)))
       (values max-with-root max-path)]))
  (cdr (helper root)))