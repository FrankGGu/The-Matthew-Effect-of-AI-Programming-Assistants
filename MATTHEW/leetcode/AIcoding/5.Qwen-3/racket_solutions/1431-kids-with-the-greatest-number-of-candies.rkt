(define/contract (kids-with-candies candies)
  (-> (listof exact-integer?) (listof boolean?))
  (let ((max-candies (apply max candies)))
    (map (lambda (c) (>= (+ c 0) max-candies)) candies)))