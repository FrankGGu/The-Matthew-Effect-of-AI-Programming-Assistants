(define (find-cheapest-price n flights src dst k)
  (define +inf.0 (expt 10 9)) ; Use a large number for infinity, as +inf.0 might behave differently with min for integer comparisons
                               ; Max possible cost: 100 cities * 10^4 price = 10^6. 10^9 is safe.

  (define current-dist (make-vector n +inf.0))
  (vector-set! current-dist src 0)

  ;; The loop runs k+1 times.
  ;; Each iteration i computes the minimum costs to reach any node using at most i stops (i+1 edges).
  ;; For k stops, we need k+1 iterations (from 0 to k).
  (for ([_ (in-range (+ k 1))])
    (define next-dist (vector-copy current-dist))
    (for ([flight flights])
      (define u (vector-ref flight 0))
      (define v (vector-ref flight 1))
      (define price (vector-ref flight 2))

      (when (not (= (vector-ref current-dist u) +inf.0))
        (vector-set! next-dist v
                     (min (vector-ref next-dist v)
                          (+ (vector-ref current-dist u) price)))))
    (set! current-dist next-dist))

  (if (= (vector-ref current-dist dst) +inf.0)
      -1
      (vector-ref current-dist dst)))