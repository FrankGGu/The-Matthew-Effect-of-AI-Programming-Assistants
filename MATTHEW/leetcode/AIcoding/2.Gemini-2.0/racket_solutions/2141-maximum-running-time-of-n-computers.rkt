(define (max-run-time n batteries)
  (define (check-time time)
    (let loop ([batteries batteries] [computers n] [total 0])
      (cond
        [(null? batteries) (= computers 0)]
        [else
         (let ([battery (car batteries)])
           (if (>= battery time)
               (loop (cdr batteries) (- computers 1) total)
               (loop (cdr batteries) computers (+ total battery)))))]))

  (define (binary-search low high)
    (if (<= low high)
        (let ([mid (floor (+ low high) 2)])
          (if (check-time mid)
              (binary-search (+ mid 1) high)
              (binary-search low (- mid 1))))
        low))

  (let ([total-power (apply + batteries)])
    (let ([max-possible-time (floor total-power n)])
      (- (binary-search 0 max-possible-time) 1))))