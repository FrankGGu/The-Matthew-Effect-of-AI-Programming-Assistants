(define (egg-drop-with-2-eggs-and-n-floors n)
  (let loop ((m 0))
    (if (>= (* m (+ m 1)) (* 2 n))
        m
        (loop (+ m 1)))))