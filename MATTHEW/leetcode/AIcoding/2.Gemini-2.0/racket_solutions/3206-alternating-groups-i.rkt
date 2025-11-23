(define (alternating-groups-i s)
  (let loop ([str (string->list s)]
             [count 1]
             [prev #f])
    (cond
      [(empty? str) count]
      [else
       (let ([curr (car str)])
         (if (or (not prev) (not (equal? prev curr)))
             (loop (cdr str) (+ count 1) curr)
             (loop (cdr str) count prev)))))))