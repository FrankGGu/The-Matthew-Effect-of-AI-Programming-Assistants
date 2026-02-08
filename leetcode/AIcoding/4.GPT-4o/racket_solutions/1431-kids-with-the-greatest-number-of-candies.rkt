(define (kidsWithCandies candies extraCandies)
  (define max-candies (apply max candies))
  (map (lambda (candy) (>= (+ candy extraCandies) max-candies)) candies))