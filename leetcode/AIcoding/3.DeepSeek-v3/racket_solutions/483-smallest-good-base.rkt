(define (smallest-good-base n)
  (let* ([n (string->number n)]
         [max-m (inexact->exact (floor (/ (log n) (log 2))))])
    (define (check k)
      (let loop ([low 2] [high (- n 1)])
        (if (> low high)
            #f
            (let* ([mid (quotient (+ low high) 2)]
                   [sum (sub1 (expt mid k))])
              (cond
                [(= (quotient sum (sub1 mid)) n] mid)
                [(< (quotient sum (sub1 mid)) n) (loop (add1 mid) high)]
                [else (loop low (sub1 mid))])))))
    (let loop ([m max-m])
      (if (< m 1)
          (- n 1)
          (let ([res (check m)])
            (if res
                res
                (loop (sub1 m))))))))