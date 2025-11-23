(define (average-salary-excluding-min-and-max salary)
  (let* ([sorted (sort salary <)]
         [len (length sorted)]
         [sum (apply + (take (drop sorted 1) (- len 2)))])
    (/ sum (- len 2))))