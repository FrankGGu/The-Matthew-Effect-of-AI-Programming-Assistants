(define (min-patches coins target)
  (let* ([sorted-coins (sort coins <)]
         [n (length sorted-coins)])
    (let loop ([reachable 0]
               [added-coins 0]
               [i 0])
      (cond
        [(>= reachable target)
         added-coins]
        [(and (< i n)
              (<= (list-ref sorted-coins i) (+ reachable 1)))
         (loop (+ reachable (list-ref sorted-coins i))
               added-coins
               (+ i 1))]
        [else
         (loop (+ reachable (+ reachable 1))
               (+ added-coins 1)
               i)]))))