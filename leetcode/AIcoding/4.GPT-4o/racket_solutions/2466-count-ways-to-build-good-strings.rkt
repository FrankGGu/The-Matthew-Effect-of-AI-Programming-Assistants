(define (countGoodStrings low high zero one)
  (define mod 1000000007)
  (define dp (make-vector (+ high 1) -1))

  (define (helper len)
    (if (> len high) 0)
    (if (vector-ref dp len) (vector-ref dp len))
    (define res 0)
    (when (>= len low) (set! res (add1 res)))
    (set! res (modulo (+ res (helper (+ len zero))) mod))
    (set! res (modulo (+ res (helper (+ len one))) mod))
    (vector-set! dp len res)
    res)

  (helper 0))

(countGoodStrings 1 3 1 1)