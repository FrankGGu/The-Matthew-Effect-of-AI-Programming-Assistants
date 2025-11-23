(define (find-neither-min-nor-max nums)
  (if (< (length nums) 3)
      -1
      (let* ((min-val (apply min nums))
             (max-val (apply max nums)))
        (for/first ((n nums) #:when (and (not (= n min-val)) (not (= n max-val))))
          n))))