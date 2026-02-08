(define (splitArraySameAverage A)
  (define n (length A))
  (define total (apply + A))
  (define (canPartition k sum len)
    (cond
      [(= k 0) (= sum 0)]
      [(or (= len 0) (< k 0)) #f]
      [else (or (canPartition (- k 1) (- sum (list-ref A (- len 1))) (- len 1))
                (canPartition k sum (- len 1)))]))
  (for/fold ([result #f]) ([k (in-range 1 n)])
    (if (and (zero? (modulo (* k total) n)) (canPartition k (/ (* k total) n) n))
        #t
        result))
  )