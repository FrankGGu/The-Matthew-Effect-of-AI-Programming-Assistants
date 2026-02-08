(define (trap height)
  (define n (length height))
  (define left (make-vector n 0))
  (define right (make-vector n 0))

  (for ([i (in-range n)])
    (if (= i 0)
        (vector-set! left i (vector-ref height i))
        (vector-set! left i (max (vector-ref left (- i 1)) (vector-ref height i)))))

  (for ([i (in-range (- n 1) -1 -1)])
    (if (= i (- n 1))
        (vector-set! right i (vector-ref height i))
        (vector-set! right i (max (vector-ref right (+ i 1)) (vector-ref height i)))))

  (define total-water 0)
  (for ([i (in-range n)])
    (set! total-water (+ total-water (max 0 (min (vector-ref left i) (vector-ref right i)) - (vector-ref height i)))))

  total-water)