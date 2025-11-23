(define (kth-largest-perfect-subtree-size root k)
  (define (is-perfect? root)
    (if (null? root)
        #t
        (let ((left (car root))
              (right (cdr root)))
          (cond
            [(and (null? left) (null? right)) #t]
            [(and (not (null? left)) (not (null? right)))
             (and (equal? (tree-height left) (tree-height right))
                  (is-perfect? left)
                  (is-perfect? right))]
            [else #f]))))

  (define (tree-height root)
    (if (null? root)
        -1
        (+ 1 (max (tree-height (car root)) (tree-height (cdr root))))))

  (define (tree-size root)
    (if (null? root)
        0
        (+ 1 (tree-size (car root)) (tree-size (cdr root)))))

  (define (collect-perfect-subtree-sizes root)
    (if (null? root)
        '()
        (let ((sizes (append (collect-perfect-subtree-sizes (car root))
                             (collect-perfect-subtree-sizes (cdr root)))))
          (if (is-perfect? root)
              (cons (tree-size root) sizes)
              sizes))))

  (let ((sizes (sort (remove-duplicates (collect-perfect-subtree-sizes root)) >)))
    (if (and (>= k 1) (<= k (length sizes)))
        (list-ref sizes (- k 1))
        -1)))