(define/contract (rotate matrix)
  (-> (listof (listof exact-integer?)) void?)
  (let* ([n (length matrix)]
         [matrix-vec (list->vector (map list->vector matrix))])
    (for ([i (in-range (quotient n 2))])
      (for ([j (in-range i (- n i 1))])
        (let* ([temp (vector-ref (vector-ref matrix-vec i) j)]
               [i1 (- n j 1)]
               [j1 i]
               [i2 (- n i 1)]
               [j2 (- n j 1)]
               [i3 j]
               [j3 (- n i 1)])
          (vector-set! (vector-ref matrix-vec i) j (vector-ref (vector-ref matrix-vec i3) j3))
          (vector-set! (vector-ref matrix-vec i3) j3 (vector-ref (vector-ref matrix-vec i2) j2))
          (vector-set! (vector-ref matrix-vec i2) j2 (vector-ref (vector-ref matrix-vec i1) j1))
          (vector-set! (vector-ref matrix-vec i1) j1 temp))))
    (set! matrix (map vector->list (vector->list matrix-vec)))))