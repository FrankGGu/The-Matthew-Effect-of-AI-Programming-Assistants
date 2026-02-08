(define (uniquePaths m n)
  (define (factorial x)
    (if (= x 1) 1 (* x (factorial (- x 1)))))
  (/ (factorial (+ m n -2)) (* (factorial (- m 1)) (factorial (- n 1)))))

(uniquePaths 3 7)