(define (min-cost (days costs))
  (define n (length days))
  (define dp (make-vector (+ n 1) 0))

  (define (cost i)
    (cond
      [(>= i n) 0]
      [else
       (vector-ref dp i)]))

  (define (solve i)
    (cond
      [(>= i n) 0]
      [else
       (if (zero? (vector-ref dp i))
           (begin
             (vector-set! dp i (min (+ (car costs) (solve (+ i 1)))
                                    (+ (cadr costs) (solve (+ i 7)))
                                    (+ (caddr costs) (solve (+ i 30)))))
             (cost i))
           (cost i))]))

  (solve 0))