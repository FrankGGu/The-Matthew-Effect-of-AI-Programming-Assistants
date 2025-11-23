(define (can-eat? candies-count daily-cap favorite-day)
  (let* ([type-candies (list-ref candies-count (first favorite-day))]
         [favorite-day-to-eat (+ 1 (second favorite-day))]
         [min-candies (* favorite-day-to-eat 1)]
         [max-candies (* favorite-day-to-eat daily-cap)]
         [candies-before (apply + (take candies-count (first favorite-day)))]
         [candies-after (+ candies-before type-candies)])
    (and (<= min-candies candies-after)
         (>= max-candies candies-before))))

(define (can-eat-favorite-candy-on-favorite-day candies-count queries)
  (map (lambda (q) (can-eat? candies-count (second q) (first q))) queries))