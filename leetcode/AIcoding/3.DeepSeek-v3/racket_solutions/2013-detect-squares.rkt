(define detect-squares%
  (class object%
    (super-new)
    (init-field)
    (define points (make-hash))

    (define/public (add point)
      (let ([x (car point)]
            [y (cadr point)])
        (hash-update! points x 
                      (lambda (ys) 
                        (hash-update ys y (lambda (cnt) (+ cnt 1)) 1)
                      (lambda () (make-hash (list (cons y 1)))))))

    (define/public (count point)
      (let ([x (car point)]
            [y (cadr point)]
            [res 0])
        (hash-for-each
         points
         (lambda (x2 ys)
           (when (not (= x2 x))
             (let ([d (abs (- x2 x))])
               (hash-for-each
                ys
                (lambda (y2 cnt)
                  (when (= (abs (- y2 y)) d)
                    (let ([cnt1 (hash-ref (hash-ref points x (make-hash)) y2 0)]
                          [cnt2 (hash-ref (hash-ref points x2 (make-hash)) y 0)])
                      (set! res (+ res (* cnt cnt1 cnt2)))))))))
        res))))