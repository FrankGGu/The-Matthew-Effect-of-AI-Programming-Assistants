(define (triangle-type a b c)
  (let ([sides (sort (list a b c) <)])
    (let ([a (list-ref sides 0)]
          [b (list-ref sides 1)]
          [c (list-ref sides 2)])
      (cond
        [(not (and (> a 0) (> b 0) (> c 0))) "Not A Triangle"]
        [(>= (+ a b) c)
         (cond
           [(= a b c) "Equilateral"]
           [(or (= a b) (= b c) (= a c)) "Isosceles"]
           [else "Scalene"])]
        [else "Not A Triangle"]))))