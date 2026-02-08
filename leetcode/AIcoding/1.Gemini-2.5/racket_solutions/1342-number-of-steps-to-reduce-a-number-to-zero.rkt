(define (number-of-steps num)
  (define (helper current-num steps)
    (cond
      ((zero? current-num) steps)
      ((even? current-num) (helper (/ current-num 2) (+ steps 1)))
      (else (helper (- current-num 1) (+ steps 1)))))
  (helper num 0))