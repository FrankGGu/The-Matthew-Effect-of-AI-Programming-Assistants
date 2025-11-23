(define/contract (maximum-happiness happiness k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([h (sort happiness >)] [i 0] [sum 0])
    (cond
      [(or (null? h) (zero? k)) sum]
      [else
       (define val (max 0 (- (car h) i)))
       (loop (cdr h) (add1 i) (+ sum val) (sub1 k)))])))