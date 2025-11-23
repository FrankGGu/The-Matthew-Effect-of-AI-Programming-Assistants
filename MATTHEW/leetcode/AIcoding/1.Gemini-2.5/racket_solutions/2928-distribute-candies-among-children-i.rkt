(define (distribute-candies candies max_candies_per_child)
  (for/sum ([c1 (in-range (+ max_candies_per_child 1))]
            [c2 (in-range (+ max_candies_per_child 1))])
    (let* ((c3 (- candies c1 c2)))
      (if (and (>= c3 0) (<= c3 max_candies_per_child))
          1
          0))))