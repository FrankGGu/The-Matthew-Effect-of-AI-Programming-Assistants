(define (max-running-time n batteries)
  (let* ((total-battery-sum (apply + batteries))
         (low 0)
         (high (floor (/ total-battery-sum n))))

    (define (can-run? target-time)
      (let loop ((bs batteries) (power-contributed 0))
        (if (empty? bs)
            (>= power-contributed (* n target-time))
            (loop (cdr bs) (+ power-contributed (min (car bs) target-time))))))

    (let loop ((lo low) (hi high) (ans 0))
      (if (> lo hi)
          ans
          (let ((mid (floor (/ (+ lo hi) 2))))
            (if (can-run? mid)
                (loop (+ mid 1) hi mid)
                (loop lo (- mid 1) ans)))))))