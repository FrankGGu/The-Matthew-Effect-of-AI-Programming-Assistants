(define (max-profit prices)
  (let ([n (length prices)])
    (if (zero? n)
        0
        (let ([buy (make-vector n 0)]
              [sell (make-vector n 0)]
              [cooldown (make-vector n 0)])
          (vector-set! buy 0 (- (vector-ref prices 0)))
          (for ([i (in-range 1 n)])
            (vector-set! buy i (max (vector-ref buy (- i 1))
                                     (- (vector-ref cooldown (- i 1)) (vector-ref prices i))))
            (vector-set! sell i (+ (vector-ref buy (- i 1)) (vector-ref prices i)))
            (vector-set! cooldown i (max (vector-ref cooldown (- i 1))
                                          (vector-ref sell (- i 1)))))
          (max (vector-ref sell (- n 1)) (vector-ref cooldown (- n 1)))))))