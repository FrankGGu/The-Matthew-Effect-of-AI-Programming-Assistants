#lang racket

(define (can-you-eat-your-favorite-candy-on-your-favorite-day candiesCount queries)
  (let* ([n (vector-length candiesCount)]
         [prefix-sums (make-vector n 0)])
    (when (> n 0)
      (vector-set! prefix-sums 0 0)
      (for ([i (in-range 1 n)])
        (vector-set! prefix-sums i
                     (+ (vector-ref prefix-sums (- i 1))
                        (vector-ref candiesCount (- i 1))))))

    (for/list ([query queries])
      (let* ([candyType (vector-ref query 0)]
             [day (vector-ref query 1)]
             [dailyCap (vector-ref query 2)]

             [P_ct (vector-ref prefix-sums candyType)]
             [candies_ct (vector-ref candiesCount candyType)]

             [min_day_to_start_ct (floor (/ P_ct dailyCap))]

             [max_day_to_finish_ct (+ P_ct candies_ct -1)])

        (and (>= day min_day_to_start_ct)
             (<= day max_day_to_finish_ct))))))