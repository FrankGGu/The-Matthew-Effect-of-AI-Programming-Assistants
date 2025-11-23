#lang racket

(define (clumsy x)
  (define (helper n sign)
    (cond [(<= n 0) 0]
          [(= n 1) (* 1 sign)]
          [(= n 2) (* 2 sign)]
          [(= n 3) (* 3 sign)]
          [else
           (+ (* (helper (- n 4) -1) (if (= sign 1) 1 -1))
              (* (if (= sign 1) n (* n -1))
                 (if (= (remainder n 4) 0) 1 -1)))])
    )
  )
  (helper x 1))