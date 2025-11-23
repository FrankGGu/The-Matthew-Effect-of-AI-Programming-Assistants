(define (maximum-energy energy k)
  (define n (length energy))
  (define energy-vec (list->vector energy))

  (define dp (make-vector n 0))

  (for ([i (in-range (- n 1) -1 -1)])
    (let ((current-energy (vector-ref energy-vec i)))
      (if (< (+ i k) n)
          (vector-set! dp i (+ current-energy (vector-ref dp (+ i k))))
          (vector-set! dp i current-energy))))

  (define max-val (vector-ref dp 0))
  (for ([i (in-range 1 n)])
    (set! max-val (max max-val (vector-ref dp i))))
  max-val)