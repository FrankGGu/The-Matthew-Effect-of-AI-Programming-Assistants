(define (min-swaps-couples row)
  (let* ([v (list->vector row)]
         [n (vector-length v)]
         [swaps 0])
    (for ([i (in-range 0 n 2)])
      (let* ([p1 (vector-ref v i)]
             [p1-partner (bitwise-xor p1 1)])
        (when (not (= (vector-ref v (+ i 1)) p1-partner))
          (let find-partner ([j (+ i 2)])
            (when (< j n)
              (when (= (vector-ref v j) p1-partner)
                (let ([temp (vector-ref v (+ i 1))])
                  (vector-set! v (+ i 1) (vector-ref v j))
                  (vector-set! v j temp))
                (set! swaps (+ swaps 1)))
              (unless (= (vector-ref v j) p1-partner)
                (find-partner (+ j 1))))))))
    swaps))