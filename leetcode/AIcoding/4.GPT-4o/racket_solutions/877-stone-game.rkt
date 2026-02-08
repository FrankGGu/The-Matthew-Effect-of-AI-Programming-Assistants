(define (stoneGame piles)
  (define n (length piles))
  (define dp (make-vector n (make-vector n 0)))

  (for ([i (in-range n)])
    (vector-set! (vector-ref dp i) i (vector-ref piles i)))

  (for ([length (in-range 2 n)])
    (for ([start (in-range (- n length))])
      (define end (+ start length))
      (vector-set! (vector-ref dp start) end
                   (max (- (vector-ref piles start) (vector-ref (vector-ref dp (+ start 1)) end))
                        (- (vector-ref piles end) (vector-ref (vector-ref dp start) (- end 1))))))
    )
  )

  (>= (vector-ref (vector-ref dp 0) (- n 1)) 0))