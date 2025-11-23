(define (stone-game-v stoneValue)
  (define N (vector-length stoneValue))

  (if (<= N 1)
      0
      (begin
        (define prefix-sums (make-vector (+ N 1) 0))
        (for ([i (in-range N)])
          (vector-set! prefix-sums (+ i 1) (+ (vector-ref prefix-sums i) (vector-ref stoneValue i))))

        (define (get-sum i j)
          (- (vector-ref prefix-sums (+ j 1)) (vector-ref prefix-sums i)))

        (define dp (make-vector N (lambda () (make-vector N 0))))

        (for ([len (in-range 2 (+ N 1))])
          (for ([i (in-range (+ 1 (- N len)))])
            (define j (+ i len -1))
            (define max-score 0)

            (for ([k (in-range i j)])
              (define sum-left (get-sum i k))
              (define sum-right (get-sum (+ k 1) j))

              (define current-score 0)
              (cond
                ((< sum-left sum-right)
                 (set! current-score (+ sum-left (vector-ref (vector-ref dp i) k))))
                ((> sum-left sum-right)
                 (set! current-score (+ sum-right (vector-ref (vector-ref dp (+ k 1)) j))))
                (else
                 (set! current-score (+ sum-left
                                        (max (vector-ref (vector-ref dp i) k)
                                             (vector-ref (vector-ref dp (+ k 1)) j))))))
              (set! max-score (max max-score current-score)))
            (vector-set! (vector-ref dp i) j max-score)))
        (vector-ref (vector-ref dp 0) (- N 1))))))