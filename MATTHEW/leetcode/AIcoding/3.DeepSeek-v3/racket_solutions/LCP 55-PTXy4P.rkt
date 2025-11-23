(define/contract (minimum-time time totalTrips)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (can-complete? given-time)
    (let loop ([trips 0]
               [t time])
      (if (null? t)
          (>= trips totalTrips)
          (loop (+ trips (quotient given-time (car t)))
                (cdr t)))))
  (let binary-search ([left 1]
                      [right (* (apply max time) totalTrips)])
    (if (>= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (can-complete? mid)
              (binary-search left mid)
              (binary-search (+ mid 1) right))))))