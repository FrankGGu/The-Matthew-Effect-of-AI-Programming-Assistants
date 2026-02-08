(define (predictTheWinner nums)
  (define n (length nums))
  (define dp (make-vector n (make-vector n 0)))

  (for ([i (in-range n)])
    (vector-set! (vector-ref dp i) i (list-ref nums i)))

  (for ([len (in-range 2 (+ n 1))])
    (for ([i (in-range (- n len) 0 -1)])
      (define j (+ i len -1))
      (vector-set! (vector-ref dp i) j (max (- (list-ref nums i) (vector-ref (vector-ref dp (+ i 1)) j))
                                              (- (list-ref nums j) (vector-ref (vector-ref dp i) (- j 1)))))))

  (>= (vector-ref (vector-ref dp 0) (- n 1)) 0))