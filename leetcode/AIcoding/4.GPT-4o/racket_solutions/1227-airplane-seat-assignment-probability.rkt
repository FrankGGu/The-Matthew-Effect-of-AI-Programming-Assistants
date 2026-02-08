(define (nth-person-never-takes-seat n)
  (if (= n 1)
      1.0
      (/ 1.0 4.0)))

(define (seatProbability n)
  (if (= n 1)
      1.0
      (let ((prob (/ 1.0 4.0)))
        (for ((i (in-range 2 (+ n 1))))
          (set! prob (* prob (/ (- i 1) i))))
        prob)))

(seatProbability n)