(define (product-queries n queries)
  (define (power-of-two x)
    (if (= x 0)
        1
        (expt 2 x)))

  (define (compute-product l r)
    (let loop ((i l) (prod 1))
      (if (> i r)
          prod
          (loop (+ i 1) (* prod (power-of-two i))))))

  (map (lambda (q) (compute-product (car q) (cadr q))) queries))