(define (valid-mountain-array A)
  (let* ((n (vector-length A)))
    (if (< n 3)
        #f
        (let loop-inc ((i 0))
          (if (and (< (+ i 1) n) (< (vector-ref A i) (vector-ref A (+ i 1))))
              (loop-inc (+ i 1))
              (if (or (= i 0) (= i (- n 1)))
                  #f
                  (let loop-dec ((j i))
                    (if (and (< (+ j 1) n) (> (vector-ref A j) (vector-ref A (+ j 1))))
                        (loop-dec (+ j 1))
                        (= j (- n 1))))))))))