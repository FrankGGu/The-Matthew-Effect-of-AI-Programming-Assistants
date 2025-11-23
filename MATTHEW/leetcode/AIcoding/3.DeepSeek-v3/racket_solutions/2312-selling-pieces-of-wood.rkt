(define (selling-wood m n prices)
  (let ([dp (make-vector (+ m 1) (make-vector (+ n 1) 0))])
    (for ([price prices])
      (let ([h (first price)]
            [w (second price)]
            [v (third price)])
        (vector-set! (vector-ref dp h) w (max (vector-ref (vector-ref dp h) w) v))))
    (for ([h (in-range 1 (+ m 1))])
      (for ([w (in-range 1 (+ n 1))])
        (for ([k (in-range 1 (quotient h 2))])
          (vector-set! (vector-ref dp h) w 
                       (max (vector-ref (vector-ref dp h) w) 
                            (+ (vector-ref (vector-ref dp k) w) 
                                (vector-ref (vector-ref dp (- h k)) w)))))
        (for ([k (in-range 1 (quotient w 2))])
          (vector-set! (vector-ref dp h) w 
                       (max (vector-ref (vector-ref dp h) w) 
                            (+ (vector-ref (vector-ref dp h) k) 
                                (vector-ref (vector-ref dp h) (- w k)))))
        (vector-set! (vector-ref dp h) w 
                     (max (vector-ref (vector-ref dp h) w) 
                          (vector-ref (vector-ref dp h) w)))))
    (vector-ref (vector-ref dp m) n)))