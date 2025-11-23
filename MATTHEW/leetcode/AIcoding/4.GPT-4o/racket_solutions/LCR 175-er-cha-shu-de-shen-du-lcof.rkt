(define (maxDepth root)
  (if (null? root)
      0
      (+ 1 (max (maxDepth (car (cdr root)))
                 (maxDepth (cadr (cdr root)))))))