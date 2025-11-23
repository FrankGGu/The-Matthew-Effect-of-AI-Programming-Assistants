(define (kids-with-candies candies extra-candies)
  (let* ([max-candies (apply max candies)]
         [result (map (lambda (c) (>= (+ c extra-candies) max-candies)) candies)])
    result))