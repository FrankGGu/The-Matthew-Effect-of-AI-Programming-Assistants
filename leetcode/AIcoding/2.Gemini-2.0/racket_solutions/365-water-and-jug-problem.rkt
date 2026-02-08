(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (can-measure-water jug1Capacity jug2Capacity targetCapacity)
  (cond
    [(= targetCapacity 0) #t]
    [(> targetCapacity (+ jug1Capacity jug2Capacity)) #f]
    [else (= (remainder targetCapacity (gcd jug1Capacity jug2Capacity)) 0)]))