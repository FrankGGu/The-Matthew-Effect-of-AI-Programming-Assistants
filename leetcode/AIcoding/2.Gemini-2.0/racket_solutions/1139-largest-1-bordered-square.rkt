(define (largest1-bordered-square matrix)
  (let* ([rows (length matrix)]
         [cols (length (car matrix))]
         [dp (make-vector (+ 1 rows) (make-vector (+ 1 cols) 0))])
    (for* ([i (in-range 1 (+ 1 rows))]
           [j (in-range 1 (+ 1 cols))])
      (vector-set! (vector-ref dp i) j (if (= (list-ref (list-ref matrix (- i 1)) (- j 1)) 1) 1 0)))
    (let loop ([side (min rows cols)]
               [max-side 0])
      (if (zero? side)
          max-side
          (let loop2 ([i 0])
            (if (> i (- rows side) )
                (loop (- side 1) max-side)
                (let loop3 ([j 0])
                  (if (> j (- cols side))
                      (loop2 (+ i 1))
                      (let* ([right (+ j side -1)]
                             [bottom (+ i side -1)])
                        (if (and (= (vector-ref (vector-ref dp i) j) 1)
                                 (= (vector-ref (vector-ref dp i) (+ j side -1)) 1)
                                 (= (vector-ref (vector-ref dp (+ i side -1)) j) 1)
                                 (= (vector-ref (vector-ref dp (+ i side -1)) (+ j side -1)) 1)
                                 (for/and ([k (in-range j (+ j side))])
                                   (= (vector-ref (vector-ref dp i) k) 1))
                                 (for/and ([k (in-range j (+ j side))])
                                   (= (vector-ref (vector-ref dp (+ i side -1)) k) 1))
                                 (for/and ([k (in-range i (+ i side))])
                                   (= (vector-ref (vector-ref dp k) j) 1))
                                 (for/and ([k (in-range i (+ i side))])
                                   (= (vector-ref (vector-ref dp k) (+ j side -1)) 1)))
                            (loop side (max max-side side))
                            (loop3 (+ j 1)))))))))))))