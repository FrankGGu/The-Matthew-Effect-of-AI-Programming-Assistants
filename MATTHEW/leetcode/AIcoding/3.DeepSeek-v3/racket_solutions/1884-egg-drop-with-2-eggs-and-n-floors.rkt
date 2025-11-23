(define (two-egg-drop n)
  (let loop ([k 1])
    (if (>= (* k (add1 k)) (* 2 n))
        k
        (loop (add1 k)))))