(define (super-egg-drop k n)
  (let loop ([m 1]
             [dp (make-vector (add1 k) 0)])
    (let ([new-dp (make-vector (add1 k) 0)])
      (for ([i (in-range 1 (add1 k))])
        (vector-set! new-dp i (+ (vector-ref dp (sub1 i)) (vector-ref dp i) 1))
      (if (>= (vector-ref new-dp k) n)
          m
          (loop (add1 m) new-dp)))))