(define (maximum-points-after-enemy-battles enemyEnergies currentEnergies)
  (let* ((n (length enemyEnergies))
         (sorted-enemies (sort enemyEnergies <)))
    (if (= n 0)
        0
        (let loop ((l 0)
                   (r (- n 1))
                   (current-energy currentEnergies)
                   (points 0))
          (cond
            ((> l r)
             points)
            ((>= current-energy (list-ref sorted-enemies l))
             (loop (+ l 1)
                   r
                   (- current-energy (list-ref sorted-enemies l))
                   (+ points 1)))
            ((and (> points 0) (< l r))
             (loop l
                   (- r 1)
                   (+ current-energy (list-ref sorted-enemies r))
                   (- points 1)))
            (else
             points))))))