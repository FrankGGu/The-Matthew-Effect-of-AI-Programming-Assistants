(define (stone-game-vii stones)
  (let* ([n (length stones)]
         [prefix (make-vector (+ n 1) 0)]
         [dp (make-vector n (make-vector n 0))])
    (for ([i (in-range n)])
      (vector-set! prefix (+ i 1) (+ (vector-ref prefix i) (list-ref stones i))))
    (for ([len (in-range 2 (+ n 1))])
      (for ([i (in-range 0 (- n len -1))])
        (let ([j (+ i len -1)])
          (vector-set! (vector-ref dp i) j
                       (max (- (vector-ref prefix (+ j 1)) (vector-ref prefix (+ i 1)) (vector-ref (vector-ref dp (+ i 1)) j))
                            (- (vector-ref prefix j) (vector-ref prefix i) (vector-ref (vector-ref dp i) (- j 1)))))))
    (vector-ref (vector-ref dp 0) (- n 1))))