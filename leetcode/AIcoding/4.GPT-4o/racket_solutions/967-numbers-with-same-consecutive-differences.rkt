#lang racket

(define (numsSameConsecDiff n k)
  (define (dfs num len)
    (if (= len n)
        (list num)
        (let* ((last-digit (modulo num 10))
               (next-digits (remove 
                              (lambda (x) (or (< x 0) (> x 9))) 
                              (list (+ last-digit k) (- last-digit k)))))
          (apply append (map (lambda (next) (dfs (+ (* num 10) next) (+ len 1))) next-digits)))))

  (if (= n 1) (range 10) (apply append (map (lambda (i) (dfs i 1)) (range 1 10)))))

(numsSameConsecDiff 3 7)