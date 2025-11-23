(define (minOperations n)
  (define (helper n count)
    (if (= n 0)
        count
        (if (even? n)
            (helper (/ n 2) (+ count 1))
            (helper (- n 1) (+ count 1)))))
  (helper n 0))

(minOperations n)