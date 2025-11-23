(define (right-triangles grid)
  (let* ([m (length grid)]
         [n (length (car grid))]
         [row-counts (make-vector m 0)]
         [col-counts (make-vector n 0)])

    (for ([r (in-range m)])
      (for ([c (in-range n)])
        (when (= (list-ref (list-ref grid r) c) 1)
          (vector-set! row-counts r (+ (vector-ref row-counts r) 1))
          (vector-set! col-counts c (+ (vector-ref col-counts c) 1)))))

    (let ([total-triangles 0])
      (for ([r (in-range m)])
        (for ([c (in-range n)])
          (when (= (list-ref (list-ref grid r) c) 1)
            (let ([num-other-in-row (- (vector-ref row-counts r) 1)]
                  [num-other-in-col (- (vector-ref col-counts c) 1)])
              (set! total-triangles (+ total-triangles (* num-other-in-row num-other-in-col))))))
      total-triangles)))