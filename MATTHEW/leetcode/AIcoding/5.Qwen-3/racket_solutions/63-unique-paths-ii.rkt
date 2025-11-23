(define (unique-paths-with-obstacles grid)
  (let ((m (length grid))
        (n (length (car grid))))
    (let ((dp (make-vector m (make-vector n 0))))
      (when (and (>= m 1) (>= n 1) (not (equal? (list-ref grid 0) (list 1))))
        (vector-set! dp 0 0 (if (equal? (list-ref (list-ref grid 0) 0) 1) 0 1)))
      (for ([i (in-range m)])
        (for ([j (in-range n)])
          (cond
            [(and (= i 0) (= j 0)) (vector-set! dp 0 0 (if (equal? (list-ref (list-ref grid 0) 0) 1) 0 1))]
            [(equal? (list-ref (list-ref grid i) j) 1) (vector-set! dp i j 0)]
            [else
             (let ([up (if (> i 0) (vector-ref (vector-ref dp (- i 1)) j) 0)]
                   [left (if (> j 0) (vector-ref (vector-ref dp i) (- j 1)) 0)])
               (vector-set! dp i j (+ up left)))])))
      (vector-ref (vector-ref dp (- m 1)) (- n 1)))))