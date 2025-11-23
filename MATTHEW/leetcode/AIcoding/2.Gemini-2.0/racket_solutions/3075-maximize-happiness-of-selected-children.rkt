(define (maximize-happiness n m candies)
  (let loop ([candies (sort candies >)]
             [happiness 0]
             [children m])
    (cond
      [(or (zero? children) (null? candies)) happiness]
      [(>= (car candies) children) (loop (cdr candies) (+ happiness children) 0)]
      [else (loop (cdr candies) (+ happiness (car candies)) (- children (car candies)))])))