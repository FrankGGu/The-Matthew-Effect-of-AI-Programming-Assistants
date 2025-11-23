(define (count-of-pairs n x y)
  (define ans (make-vector n 0)) ; ans[k-1] stores the count for distance k

  (for* ([i (in-range 1 (+ n 1))]
         [j (in-range (+ i 1) (+ n 1))])
    (let* ([d1 (abs (- i j))]
           [d2 (+ (abs (- i x)) 1 (abs (- j y)))]
           [d3 (+ (abs (- i y)) 1 (abs (- j x)))]
           [min-dist (min d1 d2 d3)])
      (vector-set! ans (- min-dist 1) (+ (vector-ref ans (- min-dist 1)) 1))))

  (vector->list ans))