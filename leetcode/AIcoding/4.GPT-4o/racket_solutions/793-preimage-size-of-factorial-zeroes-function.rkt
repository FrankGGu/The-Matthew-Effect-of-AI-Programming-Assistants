(define (preimageSizeFZF K)
  (define (zeroes n)
    (define (count-factors n)
      (if (< n 5) 0
          (+ (count-factors (floor (/ n 5))) (floor (/ n 5)))))
    (count-factors n))

  (define (binary-search left right)
    (if (> left right)
        0
        (let ((mid (floor (/ (+ left right) 2))))
          (let ((z (zeroes mid)))
            (cond
              ((< z K) (binary-search (+ mid 1) right))
              ((> z K) (binary-search left (- mid 1)))
              (else
               (+ 1 (binary-search (+ mid 1) right) (binary-search left (- mid 1)))))))))

  (binary-search 0 (* 5 (+ K 1)))
)