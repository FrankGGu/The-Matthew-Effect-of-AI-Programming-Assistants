(define (distributeCandies candies)
  (define unique-candies (length (remove-duplicates candies)))
  (min unique-candies (/ (length candies) 2)))