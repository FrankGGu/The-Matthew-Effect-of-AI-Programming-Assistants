(define (lastRemaining n)
  (define (f n step)
    (if (= n 1)
        1
        (+ step (f (/ n 2) (* 2 step))))
  (f n 1))

(lastRemaining n)