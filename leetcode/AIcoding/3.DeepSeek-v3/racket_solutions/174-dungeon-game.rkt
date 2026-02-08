(define/contract (calculate-minimum-hp dungeon)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([m (length dungeon)]
         [n (length (car dungeon))]
         [dp (make-vector m (make-vector n 0))])
    (for ([i (in-range (- m 1) -1 -1)])
      (for ([j (in-range (- n 1) -1 -1)])
        (cond
          [(and (= i (- m 1)) (= j (- n 1)))
           (vector-set! (vector-ref dp i) j (max 1 (- 1 (list-ref (list-ref dungeon i) j))))]
          [(= i (- m 1))
           (vector-set! (vector-ref dp i) j (max 1 (- (vector-ref (vector-ref dp i) (+ j 1)) (list-ref (list-ref dungeon i) j))))]
          [(= j (- n 1))
           (vector-set! (vector-ref dp i) j (max 1 (- (vector-ref (vector-ref dp (+ i 1)) j) (list-ref (list-ref dungeon i) j))))]
          [else
           (vector-set! (vector-ref dp i) j (max 1 (- (min (vector-ref (vector-ref dp (+ i 1)) j) (vector-ref (vector-ref dp i) (+ j 1))) (list-ref (list-ref dungeon i) j)))])))
    (vector-ref (vector-ref dp 0) 0)))