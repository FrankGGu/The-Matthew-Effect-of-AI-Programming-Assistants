(define (wateringPlants plants capacity)
  (define (helper index current-capacity steps)
    (if (>= index (length plants))
        steps
        (let ((needed (list-ref plants index)))
          (if (<= current-capacity needed)
              (helper (+ index 1) capacity (+ steps index (* 2 (if (> index 0) 1 0))))
              (helper (+ index 1) (- current-capacity needed) (+ steps 1))))))
  (helper 0 capacity 0))

(wateringPlants '(2 2 3 3 4 4) 5)