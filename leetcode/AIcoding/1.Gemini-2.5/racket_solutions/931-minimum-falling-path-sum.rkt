(define (min-falling-path-sum matrix)
  (let* ([n (length matrix)]
         [matrix-vec (make-vector n)])

    ; Convert input matrix (list of lists) to vector of vectors for O(1) access
    (for ([i (in-range n)])
      (vector-set! matrix-vec i (list->vector (list-ref matrix i))))

    (let ([dp (make-vector n)]) ; dp will store rows, each row is a vector

      ; Initialize dp table (each element is a vector)
      (for ([i (in-range n)])
        (vector-set! dp i (make-vector n)))

      ; Base case: first row
      (for ([j (in-range n)])
        (vector-set! (vector-ref dp 0) j (vector-ref (vector-ref matrix-vec 0) j)))

      ; Fill dp table for subsequent rows
      (for ([i (in-range 1 n)])
        (for ([j (in-range n)])
          (let* ([current-val (vector-ref (vector-ref matrix-vec i) j)]
                 [prev-row (vector-ref dp (- i 1))]
                 ; Get values from previous row, using +inf.0 for out-of-bounds
                 [val-from-up-left (if (> j 0) (vector-ref prev-row (- j 1)) +inf.0)]
                 [val-from-up (vector-ref prev-row j)]
                 [val-from-up-right (if (< (+ j 1) n) (vector-ref prev-row (+ j 1)) +inf.0)])
            (vector-set! (vector-ref dp i) j (+ current-val (min val-from-up-left val-from-up val-from-up-right))))))

      ; The result is the minimum value in the last row of dp
      (apply min (vector->list (vector-ref dp (- n 1)))))))