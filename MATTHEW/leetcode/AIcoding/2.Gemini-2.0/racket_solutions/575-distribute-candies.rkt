(define (distribute-candies candyType)
  (let* ((num-candies (length candyType))
         (num-types (length (remove-duplicates candyType))))
    (min (/ num-candies 2) num-types)))