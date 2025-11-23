(define/contract (distance-between-bus-stops distance start destination)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let* ([n (length distance)]
         [clockwise (let loop ([i start] [sum 0])
                      (if (= i destination)
                          sum
                          (loop (modulo (add1 i) n) (+ sum (list-ref distance i)))]
         [counter-clockwise (let loop ([i destination] [sum 0])
                             (if (= i start)
                                 sum
                                 (loop (modulo (add1 i) n) (+ sum (list-ref distance i))))])
    (min clockwise counter-clockwise)))