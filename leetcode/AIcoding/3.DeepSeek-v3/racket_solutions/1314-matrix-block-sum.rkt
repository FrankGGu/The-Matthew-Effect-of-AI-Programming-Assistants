(define/contract (matrix-block-sum mat k)
  (-> (listof (listof exact-integer?)) exact-integer? (listof (listof exact-integer?)))
  (let* ([m (length mat)]
         [n (length (car mat))]
         [prefix (make-vector (+ m 1) (make-vector (+ n 1) 0))])
    (for ([i (in-range 1 (+ m 1))])
      (for ([j (in-range 1 (+ n 1))])
        (vector-set! (vector-ref prefix i) j
          (+ (vector-ref (vector-ref mat (- i 1)) (- j 1))
             (vector-ref (vector-ref prefix (- i 1)) j)
             (vector-ref (vector-ref prefix i) (- j 1))
             (- (vector-ref (vector-ref prefix (- i 1)) (- j 1)))))))
    (for/list ([i (in-range m)])
      (for/list ([j (in-range n)])
        (let* ([r1 (max 0 (- i k))]
               [c1 (max 0 (- j k))]
               [r2 (min (- m 1) (+ i k))]
               [c2 (min (- n 1) (+ j k))])
          (+ (vector-ref (vector-ref prefix (+ r2 1)) (+ c2 1))
             (- (vector-ref (vector-ref prefix r1) (+ c2 1)))
             (- (vector-ref (vector-ref prefix (+ r2 1)) c1))
             (vector-ref (vector-ref prefix r1) c1)))))))