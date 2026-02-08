(define/contract (count-negatives grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define (count-row row)
    (let loop ([low 0] [high (sub1 (length row))])
      (cond
        [(> low high) 0]
        [else
         (define mid (quotient (+ low high) 2))
         (if (negative? (list-ref row mid))
             (+ (- (length row) mid) (loop low (sub1 mid)))
             (loop (add1 mid) high))])))
  (apply + (map count-row grid)))