(define (watering-plants plants capacityA capacityB)
  (let loop ([l 0] [r (- (length plants) 1)] [a capacityA] [b capacityB] [res 0])
    (cond
      [(>= l r)
       (if (= l r)
           (let ([need (max 0 (- (list-ref plants l) (max a b)))])
             (+ res (if (> need 0) 1 0)))
           res)]
      [else
       (let ([need-a (list-ref plants l)]
             [need-b (list-ref plants r)])
         (cond
           [(>= a need-a)
            (loop (+ l 1) r (- a need-a) b res)]
           [else
            (loop (+ l 1) r capacityA b (+ res 1))])
         (cond
           [(>= b need-b)
            (loop l (- r 1) a (- b need-b) res)]
           [else
            (loop l (- r 1) a capacityB (+ res 1))]))])))

  (watering-plants plants capacityA capacityB))