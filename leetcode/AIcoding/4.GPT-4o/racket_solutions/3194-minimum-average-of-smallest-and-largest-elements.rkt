(define (minimumAverage(nums))
  (define minVal (apply min nums))
  (define maxVal (apply max nums))
  (/ (+ minVal maxVal) 2.0))

(module+ test
  (display (minimumAverage '(1 2 3 4 5))) ; Example test case
  (newline)
  (display (minimumAverage '(5 6 7 8 9))) ; Example test case
  (newline))