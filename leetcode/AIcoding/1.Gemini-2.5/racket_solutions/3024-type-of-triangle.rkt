(define (triangle-type x y z)
  (cond
    ((or (<= (+ x y) z)
         (<= (+ x z) y)
         (<= (+ y z) x))
     "none")
    ((and (= x y) (= y z))
     "equilateral")
    ((or (= x y) (= x z) (= y z))
     "isosceles")
    (else
     "scalene")))