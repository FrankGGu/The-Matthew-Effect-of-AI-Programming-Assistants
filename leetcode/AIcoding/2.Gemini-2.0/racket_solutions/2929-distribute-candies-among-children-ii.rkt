(define (distribute-candies n limit)
  (define (count-valid-z z)
    (max 0 (+ (min limit z) 1)))

  (let* ((x (min limit n))
         (result 0))
    (for ((i (in-range (min limit n) (+ 1 (- (max 0 (- n (* 2 limit))) 1) -1)))
      (set! result (+ result (count-valid-z (- n i)))))
    result))