(define/contract (minimum-time-to-break-locks locks)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([m (length locks)]
         [n (if (null? locks) 0 (length (car locks)))])
    (if (or (zero? m) (zero? n)) 0
        (let loop ([i 0] [j 0] [time 0])
          (cond
            [(>= i m) time]
            [(>= j n) (loop (add1 i) 0 time)]
            [(zero? (list-ref (list-ref locks i) j)) (loop i (add1 j) time)]
            [else
             (let ([new-time (+ time i j)])
               (loop i (add1 j) (max new-time time)))])))))