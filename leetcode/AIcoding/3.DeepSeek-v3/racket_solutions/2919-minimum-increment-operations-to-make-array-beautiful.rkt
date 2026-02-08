(define/contract (min-operations nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums nums] [ops 0])
    (cond
      [(null? nums) ops]
      [else
       (let* ([current (car nums)]
              [needed (max 0 (- k current))])
         (if (zero? needed)
             (loop (cdr nums) ops)
             (loop (cons (+ current needed) (cdr nums)) (+ ops needed))))])))