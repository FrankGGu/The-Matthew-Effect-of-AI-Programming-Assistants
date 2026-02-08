(define (longest-unequal-adjacent-groups-subsequence-ii groups strs)
  (define n (length strs))
  (define dp (make-vector n 1))

  (for* ([i (range n)]
         [j (range i)])
    (when (and (= (vector-ref groups i) (vector-ref groups j))
               (> (vector-ref dp j) (- (vector-ref dp i) 1)))
      (vector-set! dp i (+ (vector-ref dp j) 1))))

  (apply max (vector->list dp)))