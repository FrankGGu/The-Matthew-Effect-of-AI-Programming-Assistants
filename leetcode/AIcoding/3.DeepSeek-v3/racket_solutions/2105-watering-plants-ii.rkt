(define (minimum-refill plants capacityA capacityB)
  (let loop ([i 0]
             [j (sub1 (length plants))]
             [a capacityA]
             [b capacityB]
             [refills 0])
    (cond
      [(> i j) refills]
      [(= i j)
       (if (> (list-ref plants i) (max a b))
           (add1 refills)
           refills)]
      [else
       (let ([new-a (if (>= a (list-ref plants i))
                        (- a (list-ref plants i))
                        (begin (set! refills (add1 refills)) (- capacityA (list-ref plants i))))]
         (let ([new-b (if (>= b (list-ref plants j))
                          (- b (list-ref plants j))
                          (begin (set! refills (add1 refills)) (- capacityB (list-ref plants j))))])
           (loop (add1 i) (sub1 j) new-a new-b refills)))])))