(define (find-missing-and-repeated values)
  (let* ([n (vector-length values)]
         [sum-n (* n (+ n 1) 1/2)]
         [sum-sq-n (* n (+ n 1) (+ (* 2 n) -1) 1/6)]
         [sum-v (apply + (vector->list values))]
         [sum-sq-v (apply + (map (lambda (x) (* x x)) (vector->list values)))]
         [diff-sum (- sum-n sum-v)]
         [diff-sq-sum (- sum-sq-n sum-sq-v)]
         [sum-rep-miss (/ diff-sq-sum diff-sum)]
         [miss (/ (+ diff-sum sum-rep-miss) 2)]
         [rep (- sum-rep-miss miss)])
    (list (inexact->exact (round rep)) (inexact->exact (round miss)))))