#lang racket

(define (count-routes locations start finish fuel)
  (define N (length locations))
  (define MOD 1000000007)

  ;; Convert locations list to a vector for O(1) access
  (define loc-vec (list->vector locations))

  ;; dp-table[city][fuel] stores the number of routes
  ;; Initialize with -1 to indicate uncomputed states
  (define dp-table (make-vector N))
  (for ([i (in-range N)])
    (vector-set! dp-table i (make-vector (+ fuel 1) -1)))

  (define (solve current-city remaining-fuel)
    ;; If this state has already been computed, return the stored value
    (let ([memoized-val (vector-ref (vector-ref dp-table current-city) remaining-fuel)])
      (when (not (= memoized-val -1))
        memoized-val))

    ;; If not computed, calculate it
    (let ([current-routes 0])
      ;; If we are at the finish city, this is one valid route.
      ;; We count this route, and then we can continue exploring from here.
      (when (= current-city finish)
        (set! current-routes (add1 current-routes)))

      ;; Explore all possible next cities
      (for ([next-city (in-range N)])
        ;; Cannot stay in the same city for a "move"
        (when (not (= next-city current-city))
          (let* ([loc-curr (vector-ref loc-vec current-city)]
                 [loc-next (vector-ref loc-vec next-city)]
                 [cost (abs (- loc-curr loc-next))])
            ;; If we have enough fuel to travel to next-city
            (when (>= remaining-fuel cost)
              (set! current-routes
                    (modulo (+ current-routes (solve next-city (- remaining-fuel cost)))
                            MOD))))))

      ;; Store the computed result in the memoization table
      (vector-set! (vector-ref dp-table current-city) remaining-fuel current-routes)
      current-routes))

  ;; Start the DP calculation from the initial state
  (solve start fuel))