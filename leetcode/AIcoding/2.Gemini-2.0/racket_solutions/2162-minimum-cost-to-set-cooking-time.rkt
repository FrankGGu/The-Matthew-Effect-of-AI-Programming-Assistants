(define (minCostSetTime startAtMoveCost pushCost targetSeconds)
  (define (calculate-cost minutes seconds)
    (let loop ([s (number->string (max 0 (min 99 minutes)))])
      (if (string=? s "")
          0
          (+ (if (char=? (string-ref s 0) (integer->char startAtMoveCost)))
               0
               moveCost)
             (foldl + 0 (map (lambda (c) pushCost) (string->list s)))))))

  (let* ([minutes (quotient targetSeconds 60)]
         [seconds (remainder targetSeconds 60)])
    (cond
      [(>= minutes 100) (calculate-cost 99 59)]
      [else (min (calculate-cost minutes seconds)
                 (if (> seconds 0)
                     (+ moveCost (calculate-cost (sub1 minutes) (+ seconds 60)))
                     #f)))])))