(define (watering-plants plants capacity)
  (let loop ((idx 0)
             (current-water capacity)
             (total-steps 0)
             (remaining-plants plants))
    (if (empty? remaining-plants)
        total-steps
        (let ((plant-needed (car remaining-plants)))
          (if (< current-water plant-needed)
              ;; Need to refill
              (loop (+ idx 1)
                    capacity
                    (+ total-steps (* 2 idx) 1)
                    (cdr remaining-plants))
              ;; Don't need to refill
              (loop (+ idx 1)
                    (- current-water plant-needed)
                    (+ total-steps 1)
                    (cdr remaining-plants)))))))