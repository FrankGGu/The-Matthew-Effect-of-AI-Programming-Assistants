(define (maxCoins piles k)
  (define n (length piles))
  (define dp (make-vector (+ 1 k) 0))

  (for ([i (in-range n)])
    (define pile (list->vector (list-ref piles i)))
    (define pile-size (vector-length pile))
    (for ([j (in-range k -1 -1)])
      (for ([x (in-range (min pile-size j) -1 -1)])
        (define current-coins (vector-sum (vector-take pile (+ x 1))))
        (vector-set! dp j (max (vector-ref dp j) (if (zero? j) 0 (+ current-coins (vector-ref dp (- j (+ x 1)))))))))
    )
  )
  (vector-ref dp k))

(define (vector-sum v)
  (apply + (vector->list v)))

(define (vector-take v n)
  (vector->list (vector-ref v n)))

(define (maxCoins piles k)
  (max-coins piles k))