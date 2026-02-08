(define (getLastMoment n left right)
  (max (if (null? left) 0 (apply max left))
       (if (null? right) 0 (- n (apply min right)))))