(define/contract (min-elements nums limit goal)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let* ([sum (apply + nums)]
         [diff (abs (- goal sum))])
    (if (zero? diff)
        0
        (ceiling (/ diff limit)))))