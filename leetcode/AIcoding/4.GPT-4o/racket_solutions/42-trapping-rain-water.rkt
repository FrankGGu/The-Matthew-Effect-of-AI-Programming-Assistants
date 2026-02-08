(define (trap height)
  (define n (length height))
  (define left (make-vector n 0))
  (define right (make-vector n 0))

  (for ([i (in-range n)])
    (vector-set! left i (if (= i 0) (vector-ref height i) (max (vector-ref left (- i 1)) (vector-ref height i)))))

  (for ([i (in-range (- n 1) -1 -1)])
    (vector-set! right i (if (= i (- n 1)) (vector-ref height i) (max (vector-ref right (+ i 1)) (vector-ref height i)))))

  (define water 0)
  (for ([i (in-range n)])
    (set! water (+ water (max 0 (- (min (vector-ref left i) (vector-ref right i)) (vector-ref height i))))))

  water)