(define/contract (mincost-tickets days costs)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([n (length days)]
         [dp (make-vector (add1 n) +inf.0)]
         [day-set (list->set days)])
    (vector-set! dp 0 0)
    (for ([i (in-range 1 (add1 n))])
      (let ([day (list-ref days (sub1 i))])
        (vector-set! dp i (min (vector-ref dp i)
                               (+ (vector-ref dp (max 0 (- i (count (lambda (d) (<= (- day d) 0)) days))) (first costs))
                               (+ (vector-ref dp (max 0 (- i (count (lambda (d) (<= (- day d) 6)) days))) (second costs))
                               (+ (vector-ref dp (max 0 (- i (count (lambda (d) (<= (- day d) 29)) days))) (third costs))))))
    (vector-ref dp n)))