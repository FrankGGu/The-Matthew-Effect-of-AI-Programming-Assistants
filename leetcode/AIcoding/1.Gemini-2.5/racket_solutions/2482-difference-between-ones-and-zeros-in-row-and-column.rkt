(define (ones-zeros-difference grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  (define onesRow (make-vector m 0))
  (define onesCol (make-vector n 0))

  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (if (= (vector-ref (vector-ref grid i) j) 1)
          (begin
            (vector-set! onesRow i (+ (vector-ref onesRow i) 1))
            (vector-set! onesCol j (+ (vector-ref onesCol j) 1))))))

  (for/vector ([i (in-range m)])
    (for/vector ([j (in-range n)])
      (+ (* 2 (vector-ref onesRow i))
         (* 2 (vector-ref onesCol j))
         (- n)
         (- m)))))