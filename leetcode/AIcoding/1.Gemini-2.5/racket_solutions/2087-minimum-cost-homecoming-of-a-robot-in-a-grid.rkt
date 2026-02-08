(define (min-cost-homecoming-of-a-robot-in-a-grid startPos homePos rowCosts colCosts)
  (let* ((start-row (car startPos))
         (start-col (cadr startPos))
         (home-row (car homePos))
         (home-col (cadr homePos)))

    (define (calculate-cost current-pos target-pos costs-vec)
      (cond
        ((= current-pos target-pos) 0)
        ((< current-pos target-pos)
         (for/sum ([i (in-range (+ current-pos 1) (+ target-pos 1))])
           (vector-ref costs-vec i)))
        (else ; (> current-pos target-pos)
         (for/sum ([i (in-range (- current-pos 1) (- target-pos 1) -1)])
           (vector-ref costs-vec i)))))

    (+ (calculate-cost start-row home-row rowCosts)
       (calculate-cost start-col home-col colCosts))))