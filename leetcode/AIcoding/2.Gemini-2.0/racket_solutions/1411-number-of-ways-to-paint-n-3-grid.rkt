(define (num-of-ways n)
  (define (matrix-mult a b)
    (list (list (+ (* (first (first a)) (first (first b))) (* (second (first a)) (second (first b))))
              (+ (* (first (first a)) (first (second b))) (* (second (first a)) (second (second b)))))
          (list (+ (* (first (second a)) (first (first b))) (* (second (second a)) (second (first b))))
              (+ (* (first (second a)) (first (second b))) (* (second (second a)) (second (second b)))))))

  (define (matrix-pow m n)
    (if (= n 1)
        m
        (let ((half (matrix-pow m (quotient n 2))))
          (if (even? n)
              (matrix-mult half half)
              (matrix-mult m (matrix-mult half half))))))

  (let ((m '((3 2) (2 2))))
    (let ((result (matrix-pow m n)))
      (modulo (+ (* 3 (first (first result))) (* 7 (first (second result)))) 1000000007))))