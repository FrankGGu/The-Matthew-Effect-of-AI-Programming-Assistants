(define (maxCoins nums)
  (define n (length nums))
  (define padded-nums (append (list 1) nums (list 1)))
  (define dp (make-vector (+ n 2) (make-vector (+ n 2) 0)))

  (for* ([l (in-range 2 (+ n 2))])
    (for* ([i (in-range 0 (- (+ n 2) l))]
           [j (+ i l)])
      (for* ([k (in-range i (+ 1 j))])
        (vector-set! (vector-ref dp i) j
                     (max (vector-ref (vector-ref dp i) j)
                          (+ (vector-ref (vector-ref dp i) k)
                             (vector-ref (vector-ref dp (+ 1 k)) j)
                             (* (list-ref padded-nums i)
                                (list-ref padded-nums k)
                                (list-ref padded-nums j)))))))

  (vector-ref (vector-ref dp 0) (+ n 1)))