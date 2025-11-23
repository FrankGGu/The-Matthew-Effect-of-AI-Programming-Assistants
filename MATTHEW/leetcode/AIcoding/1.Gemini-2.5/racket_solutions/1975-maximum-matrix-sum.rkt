(define (max-matrix-sum matrix)
  (let* ((flat-matrix (apply append matrix)))
    (let loop ((elements flat-matrix)
               (total-sum 0)
               (neg-count 0)
               (min-abs-val +inf.0))
      (if (empty? elements)
          (if (even? neg-count)
              total-sum
              (- total-sum (* 2 min-abs-val)))
          (let* ((x (first elements))
                 (abs-x (abs x))
                 (new-total-sum (+ total-sum abs-x))
                 (new-neg-count (if (< x 0) (+ neg-count 1) neg-count))
                 (new-min-abs-val (min min-abs-val abs-x)))
            (loop (rest elements)
                  new-total-sum
                  new-neg-count
                  new-min-abs-val))))))