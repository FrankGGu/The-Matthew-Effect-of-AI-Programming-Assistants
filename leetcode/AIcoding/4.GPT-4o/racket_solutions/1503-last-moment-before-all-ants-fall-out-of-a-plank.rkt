(define (getLastMoment n left right)
  (if (null? left)
      (if (null? right) 0 n)
      (if (null? right) 0 (max (apply max left) (- n (apply min right))))))