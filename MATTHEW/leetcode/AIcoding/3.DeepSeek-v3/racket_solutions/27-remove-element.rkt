(define/contract (remove-element nums val)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums nums] [k 0])
    (cond
      [(null? nums) k]
      [(= (car nums) val) (loop (cdr nums) k)]
      [else (loop (cdr nums) (+ k 1))])))