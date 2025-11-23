(define (min-operations nums k)
  (define (helper nums ops)
    (if (>= (apply + nums) k)
        ops
        (let* ([sorted (sort nums >)]
               [max-val (car sorted)]
               [new-nums (cons (- max-val 1) (cdr sorted))])
          (helper new-nums (+ ops 1)))))
  (helper nums 0))