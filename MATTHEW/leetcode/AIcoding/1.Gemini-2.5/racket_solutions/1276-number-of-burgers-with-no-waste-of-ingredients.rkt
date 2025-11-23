(define (num-of-burgers tomatoSlices cheeseSlices)
  (let* ((jumbo-numerator (- tomatoSlices (* 2 cheeseSlices)))
         (jumbo-denominator 2))
    (cond
      ((or (< jumbo-numerator 0)
           (not (= (modulo jumbo-numerator jumbo-denominator) 0)))
       '())
      (else
       (let* ((jumbo-burgers (/ jumbo-numerator jumbo-denominator))
              (small-burgers (- cheeseSlices jumbo-burgers)))
         (cond
           ((or (< small-burgers 0))
            '())
           (else
            (list jumbo-burgers small-burgers))))))))