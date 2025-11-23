(define (k-th-largest-perfect-subtree-size root k)
  (define (is-perfect? tree)
    (if (null? tree) 
        (cons 0 #t)
        (let-values ([(left-height left-perfect) (is-perfect? (left tree))]
                     [(right-height right-perfect) (is-perfect? (right tree))])
          (if (and left-perfect right-perfect 
                   (= left-height right-height))
              (values (add1 left-height) #t)
              (values (max left-height right-height) #f)))))

  (define (sizes tree)
    (if (null? tree)
        '()
        (let-values ([(left-sizes) (sizes (left tree))]
                     [(right-sizes) (sizes (right tree))])
          (cons (car (is-perfect? tree)) 
                (append left-sizes right-sizes)))))

  (define sizes-list (sizes root))
  (define perfect-sizes (filter (lambda (x) (and (not (null? x)) (> x 0))) sizes-list))
  (sort perfect-sizes >)
  (if (>= k (length perfect-sizes))
      -1
      (list-ref perfect-sizes (sub1 k))))