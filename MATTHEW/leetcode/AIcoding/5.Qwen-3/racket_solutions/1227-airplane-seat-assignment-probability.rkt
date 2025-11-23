(define (nth-person-gets-nth-seat n)
  (if (= n 1)
      1
      (/ 1.0 (- n 1))))