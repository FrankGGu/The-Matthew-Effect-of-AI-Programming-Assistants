(define (surface-area grid)
  (let* ((rows (vector-length grid))
         (cols (vector-length (vector-ref grid 0))))
    (for/sum ([i (in-range rows)])
      (for/sum ([j (in-range cols)])
        (let ((h (vector-ref (vector-ref grid i) j)))
          (if (= h 0)
              0
              (+ 2 ; Top and bottom faces
                 (abs (- h (if (> j 0) (vector-ref (vector-ref grid i) (sub1 j)) 0))) ; Left neighbor
                 (abs (- h (if (< j (sub1 cols)) (vector-ref (vector-ref grid i) (add1 j)) 0))) ; Right neighbor
                 (abs (- h (if (> i 0) (vector-ref (vector-ref grid (sub1 i)) j) 0))) ; Top neighbor
                 (abs (- h (if (< i (sub1 rows)) (vector-ref (vector-ref grid (add1 i)) j) 0))))))))))