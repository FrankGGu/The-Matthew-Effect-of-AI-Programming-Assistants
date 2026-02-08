(define (min-deletion-size strs)
  (let* ([n (string-length (car strs))]
         [m (length strs)]
         [dp (make-vector n 1)])
    (for ([i (in-range 1 n)])
      (for ([j (in-range 0 i)])
        (when (for/and ([s (in-list strs)])
                (char<=? (string-ref s j) (string-ref s i)))
          (vector-set! dp i (max (vector-ref dp i) (+ (vector-ref dp j) 1)))))
    (- n (apply max (vector->list dp)))))