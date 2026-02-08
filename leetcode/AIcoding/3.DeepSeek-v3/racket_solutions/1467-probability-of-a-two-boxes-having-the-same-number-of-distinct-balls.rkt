(define (get-probability balls)
  (let* ([total-balls (apply + balls)]
         [half-balls (/ total-balls 2)]
         [n (length balls)]
         [fact (lambda (x) (if (<= x 1) 1 (* x (fact (- x 1)))))])
    (if (odd? total-balls)
        0.0
        (let ([count 0]
              [valid 0])
          (let loop ([i 0]
                     [sum1 0]
                     [sum2 0]
                     [dist1 0]
                     [dist2 0]
                     [prod1 1]
                     [prod2 1]
                     [balls balls])
            (cond
              [(= i n)
               (when (and (= sum1 half-balls) (= sum2 half-balls) (= dist1 dist2))
                 (set! valid (+ valid (/ (* (fact half-balls) (fact half-balls)) (* prod1 prod2)))))]
              [else
               (for ([k (in-range 0 (+ (list-ref balls i) 1))])
                 (let ([new-sum1 (+ sum1 k)]
                       [new-sum2 (+ sum2 (- (list-ref balls i) k))]
                       [new-dist1 (if (> k 0) (+ dist1 1) dist1)]
                       [new-dist2 (if (> (- (list-ref balls i) k) 0) (+ dist2 1) dist2)]
                       [new-prod1 (* prod1 (fact k))]
                       [new-prod2 (* prod2 (fact (- (list-ref balls i) k)))])
                   (when (and (<= new-sum1 half-balls) (<= new-sum2 half-balls))
                     (loop (+ i 1) new-sum1 new-sum2 new-dist1 new-dist2 new-prod1 new-prod2 balls)))))])
          (/ valid (* (fact total-balls) (expt 2 (- n)))))))))