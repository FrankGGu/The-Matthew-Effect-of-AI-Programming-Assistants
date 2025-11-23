(define (sum-of-numbers-with-units-digit-k num k)
  (if (= num 0)
      0
      (if (= k 0)
          (if (= (remainder num 10) 0)
              (/ num 10)
              -1)
          (let ((target-unit (remainder num 10)))
            (let loop ((m 1))
              (if (> m 10)
                  -1
                  (if (and (= (remainder (* m k) 10) target-unit)
                           (<= (* m k) num))
                      m
                      (loop (+ m 1)))))))))