(define (can-measure-water jug1Capacity jug2Capacity targetCapacity)
  (cond
    ((= targetCapacity 0) #t)
    ((> targetCapacity (+ jug1Capacity jug2Capacity)) #f)
    (else
     (let ((common-divisor (gcd jug1Capacity jug2Capacity)))
       (= (modulo targetCapacity common-divisor) 0)))))