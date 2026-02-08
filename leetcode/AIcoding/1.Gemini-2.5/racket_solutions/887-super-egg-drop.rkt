(define (super-egg-drop k n)
  (define dp (make-vector (+ k 1) (lambda () (make-vector (+ n 1) 0))))

  (let loop ((m 1))
    (for ((j (in-range 1 (+ k 1))))
      (vector-set! (vector-ref dp j) m
                   (+ 1 (vector-ref (vector-ref dp (- j 1)) (- m 1))
                      (vector-ref (vector-ref dp j) (- m 1)))))
    (if (>= (vector-ref (vector-ref dp k) m) n)
        m
        (loop (+ m 1)))))