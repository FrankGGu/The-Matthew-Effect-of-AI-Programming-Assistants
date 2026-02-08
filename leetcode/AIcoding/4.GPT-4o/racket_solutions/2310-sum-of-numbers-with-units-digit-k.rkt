(define (minimumNumbers num k)
  (if (zero? num) 0)
  (define (helper count)
    (let ((sum (* count k)))
      (if (>= sum num)
          count
          (if (> count 10) -1 (helper (+ count 1))))))
  (helper 1))