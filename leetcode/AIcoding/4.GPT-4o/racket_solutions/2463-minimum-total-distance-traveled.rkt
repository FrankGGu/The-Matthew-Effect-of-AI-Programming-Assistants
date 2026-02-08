(define (minimum-total-distance robot, factory)
  (define (dp index robots)
    (if (or (zero? robots) (zero? index))
        0
        (let ((infinity (expt 10 9)))
          (define best (apply min (map (lambda (j)
                                           (if (>= j robots)
                                               infinity
                                               (+ (dp (sub1 index) (sub1 robots))
                                                  (define distance (abs (- (list-ref factory index) (list-ref robot j))))
                                                  (* distance distance))))
                                         (range 0 (add1 robots)))))
          best)))
  (dp (sub1 (length factory)) (length robot)))