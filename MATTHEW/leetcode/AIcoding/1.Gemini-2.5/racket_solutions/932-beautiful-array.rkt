#lang racket

(define (beautiful-array n)
  (if (= n 1)
      '(1)
      (let* ([n-odd (ceiling (/ n 2.0))]
             [n-even (floor (/ n 2.0))]
             [arr-odd (beautiful-array n-odd)]
             [arr-even (beautiful-array n-even)])
        (append (map (lambda (x) (- (* 2 x) 1)) arr-odd)
                (map (lambda (x) (* 2 x)) arr-even)))))