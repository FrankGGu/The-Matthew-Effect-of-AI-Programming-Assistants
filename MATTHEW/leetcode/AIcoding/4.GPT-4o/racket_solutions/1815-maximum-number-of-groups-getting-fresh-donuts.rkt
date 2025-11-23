(define (maxNumberOfGroups ls)
  (define (helper n k)
    (if (or (< n 0) (< k 0))
        0
        (if (>= n (+ (* k (+ 1 k)) (* k k)))
            (+ 1 (helper (- n (* k (+ 1 k))) (+ 1 k)))
            0)))
  (helper ls 1))

(maxNumberOfGroups <input>)