(define/contract (kids-with-candies candies extraCandies)
  (-> (listof exact-integer?) exact-integer? (listof boolean?))
  (let ([max-candies (apply max candies)])
    (map (lambda (c) (>= (+ c extraCandies) max-candies)) candies)))