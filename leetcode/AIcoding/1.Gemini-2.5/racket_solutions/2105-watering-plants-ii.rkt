(define (watering-plants-ii plants capacityA capacityB)
  (let* ((n (vector-length plants)))
    (let loop ((left 0)
               (right (- n 1))
               (current-water-a capacityA)
               (current-water-b capacityB)
               (refills 0))
      (cond
        ((> left right)
         refills)

        ((= left right)
         (let ((plant-water (vector-ref plants left)))
           (if (>= current-water-a current-water-b)
               (if (< current-water-a plant-water)
                   (+ refills 1)
                   refills)
               (if (< current-water-b plant-water)
                   (+ refills 1)
                   refills))))

        (else
         (let* ((plant-a-water (vector-ref plants left))
                (plant-b-water (vector-ref plants right)))

           (let* ((alice-refill-needed (< current-water-a plant-a-water))
                  (bob-refill-needed (< current-water-b plant-b-water))
                  (new-refills (+ refills
                                  (if alice-refill-needed 1 0)
                                  (if bob-refill-needed 1 0)))
                  (water-a-after-refill (if alice-refill-needed capacityA current-water-a))
                  (water-b-after-refill (if bob-refill-needed capacityB current-water-b)))

             (loop (+ left 1)
                   (- right 1)
                   (- water-a-after-refill plant-a-water)
                   (- water-b-after-refill plant-b-water)
                   new-refills)))))))