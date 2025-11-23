(define (invert-tree root)
  (if (null? root)
      null
      (let ((temp (car root)))
        (set-car! root (invert-tree (cdr root)))
        (set-cdr! root (invert-tree temp)))
      root))