(define (subtree-inversion-sum root)
  (define (invert-tree root)
    (if (null? root)
        null
        (let ((temp (car root)))
          (set-car! root (cdr root))
          (set-cdr! root temp)
          (invert-tree (car root))
          (invert-tree (cdr root))
          root)))

  (define (subtree-sum root)
    (if (null? root)
        0
        (+ (car root) (subtree-sum (cdr root)))))

  (let ((inverted-root (invert-tree (if (null? root) null (cons (car root) (cdr root))))))
    (subtree-sum inverted-root)))