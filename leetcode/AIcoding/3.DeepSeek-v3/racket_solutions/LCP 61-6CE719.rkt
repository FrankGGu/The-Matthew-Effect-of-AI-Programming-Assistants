(define/contract (temperature-trend temperatureA temperatureB)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (define (trend a b)
    (cond [(> a b) 1]
          [(< a b) -1]
          [else 0]))
  (let loop ([i 1] [count 0] [max-count 0])
    (if (>= i (length temperatureA))
        max-count
        (let ([t1 (trend (list-ref temperatureA (- i 1)) (list-ref temperatureA i))]
              [t2 (trend (list-ref temperatureB (- i 1)) (list-ref temperatureB i))])
          (if (= t1 t2)
              (loop (+ i 1) (+ count 1) (max max-count (+ count 1)))
              (loop (+ i 1) 0 max-count))))))