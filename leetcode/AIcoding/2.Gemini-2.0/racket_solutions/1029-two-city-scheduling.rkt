(define (two-city-sched costs)
  (let* ([n (length costs)]
         [sorted-costs (sort costs (lambda (x y) (< (- (first x) (second x)) (- (first y) (second y)))))]
         [first-half (take sorted-costs (/ n 2))]
         [second-half (drop sorted-costs (/ n 2))]
         [sum-a (apply + (map first first-half))]
         [sum-b (apply + (map second second-half))])
    (+ sum-a sum-b)))