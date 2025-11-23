(define (stone-game-vii stones)
  (define n (length stones))
  (define prefix-sum (make-vector (+ n 1) 0))
  (for/fold ([i 1])
            ([s stones]
             [idx (in-range n)])
    (vector-set! prefix-sum i (+ s (vector-ref prefix-sum idx)))
    (+ i 1))

  (define dp (make-vector n (make-vector n 0)))

  (for/fold ([len 2])
            ([i (in-range (- n 1))])
    (for/fold ([j (+ i len)])
              ([k (in-range i (- n len))])
      (let* ([l (+ k len)]
             [sum-k (vector-ref prefix-sum (+ l 1))]
             [sum-i (vector-ref prefix-sum k)]
             [rem (- sum-k sum-i)])
        (vector-set! (vector-ref dp k) l (max (- rem (vector-ref (vector-ref dp (+ k 1)) l))
                                               (- rem (vector-ref (vector-ref dp k) (- l 1)))))))
      (+ j 1))
    (+ len 1))

  (vector-ref (vector-ref dp 0) (- n 1)))