(define (max-side-length matrix threshold)
  (define m (length matrix))
  (define n (length (car matrix)))
  (define prefix-sum (make-matrix (+ m 1) (+ n 1) 0))

  (for* ([i (in-range 1 (+ m 1))]
         [j (in-range 1 (+ n 1))])
    (matrix-set! prefix-sum i j (+ (matrix-ref matrix (- i 1) (- j 1))
                                  (matrix-ref prefix-sum (- i 1) j)
                                  (matrix-ref prefix-sum i (- j 1))
                                  (- (matrix-ref prefix-sum (- i 1) (- j 1))))))

  (define (get-sum r1 c1 r2 c2)
    (- (+ (matrix-ref prefix-sum r2 c2)
          (matrix-ref prefix-sum (- r1 1) (- c1 1)))
       (+ (matrix-ref prefix-sum (- r1 1) c2)
          (matrix-ref prefix-sum r2 (- c1 1)))))

  (define (check k)
    (for* ([i (in-range k (+ m 1))]
           [j (in-range k (+ n 1))])
      (when (<= (get-sum (- i k -1) (- j k -1) i j) threshold)
        (return #t)))
    #f)

  (define (binary-search low high)
    (if (> low high)
        (- low 1)
        (let ([mid (floor (/ (+ low high) 2))])
          (if (check mid)
              (binary-search (+ mid 1) high)
              (binary-search low (- mid 1))))))

  (binary-search 0 (min m n)))