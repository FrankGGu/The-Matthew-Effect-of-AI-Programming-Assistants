#lang racket

(define (min-steps n)
  (cond [(= n 1) 0]
        [(even? n) (+ 2 (min-steps (/ n 2)))]
        [else (let loop ([i 3])
                (if (> i (sqrt n)) n
                    (if (= (modulo n i) 0)
                        (+ i (min-steps (/ n i)))
                        (loop (+ i 2)))))]))