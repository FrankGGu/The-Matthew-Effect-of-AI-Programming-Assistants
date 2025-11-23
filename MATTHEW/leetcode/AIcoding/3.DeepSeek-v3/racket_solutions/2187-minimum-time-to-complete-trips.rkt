(define/contract (minimum-time time totalTrips)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (can-complete? given-time)
    (let loop ([trips 0]
               [t (car time)]
               [rest-time (cdr time)])
      (if (null? rest-time)
          (>= (+ trips (quotient given-time t)) totalTrips)
          (if (>= trips totalTrips)
              #t
              (loop (+ trips (quotient given-time t))
                    (car rest-time)
                    (cdr rest-time))))))
  (let binary-search ([left 1]
                      [right (* totalTrips (apply max time))])
    (if (= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (can-complete? mid)
              (binary-search left mid)
              (binary-search (+ mid 1) right))))))