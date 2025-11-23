(define (selling-wood m n prices)
  (let ((dp (make-vector (+ m 1) (make-vector (+ n 1) 0))))
    (for ((price prices))
      (let ((h (car price)) (w (cadr price)) (p (caddr price)))
        (for ((i (in-range h (+ m 1)))
              (j (in-range w (+ n 1))))
          (vector-set! (vector-ref dp i) j
                       (+ (vector-ref (vector-ref dp i) j) p)))))

    (for ((i (in-range 1 (+ m 1)))
          (j (in-range 1 (+ n 1))))
      (for ((k (in-range 1 i)))
        (vector-set! (vector-ref dp i) j
                     (max (vector-ref (vector-ref dp i) j)
                          (+ (vector-ref (vector-ref dp k) j)
                             (vector-ref (vector-ref dp (- i k)) j)))))
      (for ((k (in-range 1 j)))
        (vector-set! (vector-ref dp i) j
                     (max (vector-ref (vector-ref dp i) j)
                          (+ (vector-ref (vector-ref dp i) k)
                             (vector-ref (vector-ref dp i) (- j k)))))))
    (vector-ref (vector-ref dp m) n)))