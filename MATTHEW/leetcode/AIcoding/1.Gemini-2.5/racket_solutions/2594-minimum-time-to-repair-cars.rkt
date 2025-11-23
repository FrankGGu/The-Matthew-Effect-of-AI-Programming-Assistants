(define (minimum-time-to-repair-cars ranks cars)
  (let* ((max-rank (apply max ranks))
         (low 1)
         (high (* max-rank cars cars)) ; Upper bound: highest rank, all cars by one mechanic
         (ans high)) ; Initialize answer to a maximum possible value

    (let loop ((l low) (h high) (current-ans ans))
      (if (> l h)
          current-ans
          (let* ((mid (+ l (quotient (- h l) 2))) ; Calculate mid to prevent potential overflow
                 (cars-repaired (let inner-loop ((rs ranks) (total 0))
                                  (if (empty? rs)
                                      total
                                      (let* ((rank (car rs))
                                             (k-squared (quotient mid rank))
                                             (k (floor (sqrt k-squared)))) ; Calculate cars repaired by this mechanic
                                        (inner-loop (cdr rs) (+ total k)))))))
            (if (>= cars-repaired cars)
                (loop l (- mid 1) mid) ; mid is a possible answer, try to find a smaller time
                (loop (+ mid 1) h current-ans)))))))