(define (number-of-steps num)
  (define (helper n steps)
    (if (= n 0)
        steps
        (if (even? n)
            (helper (/ n 2) (+ steps 1))
            (helper (- n 1) (+ steps 1)))))
  (helper num 0))