#lang racket

(define (max a b) (if (> a b) a b))

(define (max-turbulence-size nums)
  (define len (length nums))
  (if (<= len 1) len
      (let loop ([i 1] [up 1] [down 1] [max-len 1])
        (cond [(= i len) max-len]
              [else
               (let ([current (list-ref nums i)]
                     [prev (list-ref nums (- i 1))])
                 (if (> current prev)
                     (loop (+ i 1) (+ up 1) 1 (max max-len (+ up 1)))
                     (if (< current prev)
                         (loop (+ i 1) 1 (+ down 1) (max max-len (+ down 1)))
                         (loop (+ i 1) 1 1 max-len))))]))))