(define (find-peak-matrix matrix)
  (define (is-peak i j)
    (let ([val (list-ref (list-ref matrix i) j)])
      (and (or (= i 0) (< (list-ref (list-ref matrix (- i 1) ) j) val))
           (or (= i (- (length matrix) 1)) (< (list-ref (list-ref matrix (+ i 1) ) j) val))
           (or (= j 0) (< (list-ref (list-ref matrix i) (- j 1)) val))
           (or (= j (- (length (list-ref matrix 0)) 1)) (< (list-ref (list-ref matrix i) (+ j 1)) val)))))

  (define (search i j)
    (if (is-peak i j)
        (list i j)
        (let* ([down (if (< i (- (length matrix) 1)) (list-ref (list-ref matrix (+ i 1) ) j) -inf.0)]
               [right (if (< j (- (length (list-ref matrix 0)) 1)) (list-ref (list-ref matrix i) (+ j 1)) -inf.0)]
               [max-val (max down right)])
          (if (> down max-val)
              (search (+ i 1) j)
              (search i (+ j 1))))))

  (search 0 0))