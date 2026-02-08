(define (maxSizeSlices slices)
  (define n (/ (length slices) 3))
  (define (dp i j k)
    (if (= k 0) 0
        (if (or (= i (length slices)) (< j 0)) -1
            (let ((take (if (>= j 0) (+ (list-ref slices i) (dp (+ i 1) (- j 1) (- k 1))) 0)))
              (max (dp (+ i 1) j k) take)))))
  (max (dp 0 n n) (dp 1 n n)))

(define (maxSizeSlices slices)
  (max (maxSizeSlices slices) (maxSizeSlices (reverse slices))))