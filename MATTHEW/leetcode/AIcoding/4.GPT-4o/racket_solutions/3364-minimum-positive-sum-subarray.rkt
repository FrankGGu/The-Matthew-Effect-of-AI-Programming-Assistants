(define (min-positive-sum-subarray arr)
  (define (helper lst min-sum current-sum)
    (cond
      [(null? lst) (if (> min-sum 0) min-sum 0)]
      [(> (car lst) 0) (helper (cdr lst) (min min-sum (+ current-sum (car lst))) (+ current-sum (car lst)))]
      [else (helper (cdr lst) min-sum 0)]))
  (helper arr +inf.0 0))

(min-positive-sum-subarray '(1 -1 2 3 -2 5 -6)) ; Example call