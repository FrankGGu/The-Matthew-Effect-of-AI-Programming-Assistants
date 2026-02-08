(define (minDays bloomDay m k)
  (define (possible? days)
    (let loop ([flowers bloomDay] [count 0] [bouquets 0])
      (cond
        [(empty? flowers) (>= bouquets m)]
        [(<= (car flowers) days)
         (let loop2 ([rest (cdr flowers)] [consecutive 1])
           (cond
             [(empty? rest) (>= (+ bouquets (quotient (+ consecutive 1) k)) m)]
             [(<= (car rest) days) (loop2 (cdr rest) (+ consecutive 1))]
             [else (loop (cdr rest) 0 (+ bouquets (quotient (+ consecutive 1) k)))]))]
        [else (loop (cdr flowers) 0 bouquets)])))

  (define (binary-search left right)
    (cond
      [(>= left right) left]
      [else
       (let ([mid (floor (+ left right) 2)])
         (if (possible? mid)
             (binary-search left mid)
             (binary-search (+ mid 1) right)))]))

  (let ([n (length bloomDay)])
    (if (> (* m k) n)
        -1
        (binary-search (apply min bloomDay) (apply max bloomDay)))))