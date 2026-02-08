(define (balanced-binary-tree? root)
  (define (height root)
    (if (null? root)
        0
        (+ 1 (max (height (car root)) (height (cdr root))))))

  (define (is-balanced root)
    (if (null? root)
        #t
        (and (<= (abs (- (height (car root)) (height (cdr root)))) 1)
             (is-balanced (car root))
             (is-balanced (cdr root)))))

  (is-balanced root))