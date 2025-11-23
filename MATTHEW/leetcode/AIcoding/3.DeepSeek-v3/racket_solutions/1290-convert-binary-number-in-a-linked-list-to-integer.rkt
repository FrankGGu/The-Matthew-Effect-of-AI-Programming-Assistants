(define/contract (get-decimal-value head)
  (-> (or/c null? list?) exact-integer?)
  (let loop ([current head] [result 0])
    (if (null? current)
        result
        (loop (cdr current) (+ (* result 2) (car current))))))