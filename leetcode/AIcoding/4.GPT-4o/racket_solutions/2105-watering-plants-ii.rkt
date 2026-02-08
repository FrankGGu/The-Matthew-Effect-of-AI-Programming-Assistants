(define (watering-plants plants capacity1 capacity2)
  (define (helper index water1 water2 steps)
    (cond
      ((= index (length plants)) steps)
      ((>= water1 (list-ref plants index))
       (helper (+ index 1) (- water1 (list-ref plants index)) water2 steps))
      ((>= water2 (list-ref plants index))
       (helper (+ index 1) water1 (- water2 (list-ref plants index)) steps))
      (else
       (let ((new-steps (+ steps 2)))
         (helper (+ index 1) capacity1 (- water2 (list-ref plants index)) new-steps)))))
  (helper 0 capacity1 capacity2 0))