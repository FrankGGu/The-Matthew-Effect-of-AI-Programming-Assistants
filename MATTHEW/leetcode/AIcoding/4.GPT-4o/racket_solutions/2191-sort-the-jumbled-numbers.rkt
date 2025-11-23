(define (sortJumbled(mapping nums)
  (define (map-number num)
    (let loop ((n num) (res 0) (multiplier 1))
      (if (zero? n)
          res
          (loop (quotient n 10)
                (+ res (* (list-ref mapping (modulo n 10)) multiplier))
                (* multiplier 10)))))
  (sort (map map-number nums) <))