(define (solve cost)
  (define n (length cost))
  (define dp (make-vector (expt 2 n) +inf.0))
  (vector-set! dp 0 0)

  (for ([mask (in-range 1 (expt 2 n))])
    (define k (bitwise-count mask))
    (define current-pos (- k 1))

    (for ([j (in-range n)])
      (when (not (= (bitwise-and mask (arithmetic-shift 1 j)) 0))
        (define prev-mask (bitwise-xor mask (arithmetic-shift 1 j)))
        (when (not (= (vector-ref dp prev-mask) +inf.0))
          (define current-cost (+ (vector-ref dp prev-mask) (list-ref (list-ref cost current-pos) j)))
          (when (< current-cost (vector-ref dp mask))
            (vector-set! dp mask current-cost))))))

  (vector-ref dp (- (expt 2 n) 1)))