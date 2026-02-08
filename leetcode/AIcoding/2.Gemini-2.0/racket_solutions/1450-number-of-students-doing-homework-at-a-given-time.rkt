(define (busy-student start-time end-time query-time)
  (length (filter (lambda (i) (and (<= (list-ref start-time i) query-time) (>= (list-ref end-time i) query-time))) (range (length start-time)))))