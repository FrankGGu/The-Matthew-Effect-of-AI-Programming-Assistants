(define (count-intergers-in-intervals intervals low high)
  (define (count-in-interval interval)
    (let* ([start (max (car interval) low)]
           [end (min (cadr interval) high)])
      (if (<= start end)
          (+ 1 (- end start))
          0)))
  (apply + (map count-in-interval intervals)))

(define (countIntervals intervals low high)
  (count-intergers-in-intervals intervals low high))