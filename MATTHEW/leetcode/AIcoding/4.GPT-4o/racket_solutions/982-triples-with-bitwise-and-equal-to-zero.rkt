(define (countTriplets arr)
  (define n (length arr))
  (define count 0)
  (for* ([i (in-range n)]
         [j (in-range n)]
         [k (in-range n)])
    (when (= 0 (bitwise-and (list-ref arr i) (list-ref arr j) (list-ref arr k)))
      (set! count (+ count 1))))
  count)