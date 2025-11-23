(define (min-cost-tickets days costs)
  (let* ([max-day (list-ref days (- (length days) 1))]
         [dp (make-vector (+ max-day 1) 0)]
         [travel-days (make-vector (+ max-day 1) #f)])

    (for-each (lambda (day) (vector-set! travel-days day #t)) days)

    (for ([i (in-range 1 (+ max-day 1))])
      (if (vector-ref travel-days i)
          (let* ([cost-1-day (+ (vector-ref dp (- i 1)) (list-ref costs 0))]
                 [cost-7-day (+ (vector-ref dp (max 0 (- i 7))) (list-ref costs 1))]
                 [cost-30-day (+ (vector-ref dp (max 0 (- i 30))) (list-ref costs 2))])
            (vector-set! dp i (min cost-1-day cost-7-day cost-30-day)))
          (vector-set! dp i (vector-ref dp (- i 1)))))

    (vector-ref dp max-day)))