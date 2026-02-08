(define/contract (has-trailing-zeros nums)
  (-> (listof exact-integer?) boolean?)
  (let loop ([nums nums] [even-count 0])
    (cond
      [(null? nums) (>= even-count 2)]
      [(even? (car nums)) (loop (cdr nums) (add1 even-count))]
      [else (loop (cdr nums) even-count)])))