(define (min-cost-climbing-stairs cost-list)
  (let* ([cost (list->vector cost-list)]
         [n (vector-length cost)]
         [dp (make-vector (+ n 1) 0)])
    (for ([i (in-range 2 (+ n 1))])
      (vector-set! dp i
                   (min (+ (vector-ref dp (- i 1)) (vector-ref cost (- i 1)))
                        (+ (vector-ref dp (- i 2)) (vector-ref cost (- i 2))))))
    (vector-ref dp n)))