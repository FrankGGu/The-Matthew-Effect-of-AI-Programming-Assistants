(define (average salary)
  (let* ([min-salary (apply min salary)]
         [max-salary (apply max salary)]
         [sum-salary (apply + salary)]
         [count (length salary)]
         [valid-sum (- sum-salary min-salary max-salary)]
         [valid-count (- count 2)])
    (/ valid-sum valid-count)))