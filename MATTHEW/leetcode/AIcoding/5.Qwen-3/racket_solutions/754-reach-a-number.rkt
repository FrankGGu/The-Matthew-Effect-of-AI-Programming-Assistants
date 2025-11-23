(define (reach-number target)
  (define (abs x) (if (< x 0) (- x) x))
  (let loop ((steps 0) (position 0))
    (if (and (>= position target) (= (modulo (- position target) 2) 0))
        steps
        (loop (+ steps 1) (+ position steps 1)))))