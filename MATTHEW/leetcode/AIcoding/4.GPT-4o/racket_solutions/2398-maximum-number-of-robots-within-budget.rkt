(define (maximumRobots chargeTimes budget)
  (define n (length chargeTimes))
  (define (helper l r budget sum)
    (if (>= r n) l
        (if (<= sum (+ (vector-ref chargeTimes r) budget))
            (helper (max l (+ r 1)) (+ r 1) budget (+ sum (vector-ref chargeTimes r)))
            (helper l (+ r 1) (- budget (vector-ref chargeTimes l)) (subtract sum (vector-ref chargeTimes l))))))
  (helper 0 0 budget 0))

(define (subtract a b)
  (if (or (null? a) (null? b)) 0
      (if (> (car a) (car b)) (car a) (subtract (cdr a) (cdr b)))))

(define (maxRobots chargeTimes budget)
  (maximumRobots chargeTimes budget))