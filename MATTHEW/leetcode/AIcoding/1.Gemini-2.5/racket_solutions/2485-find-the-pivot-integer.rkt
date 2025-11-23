(define (pivot-integer n)
  (let* ((sum-val (/ (* n (+ n 1)) 2))
         (x-float (sqrt sum-val))
         (x-int (round x-float)))
    (if (and (= x-float (exact->inexact x-int))
             (= (* x-int x-int) sum-val))
        x-int
        -1)))