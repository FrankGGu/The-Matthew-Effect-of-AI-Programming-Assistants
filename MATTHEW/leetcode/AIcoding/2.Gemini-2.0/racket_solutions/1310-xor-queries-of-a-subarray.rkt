(define (xor-queries arr queries)
  (let* ((n (length arr))
         (prefix-xor (make-vector (add1 n) 0)))
    (for/fold ([i 1])
              ([x (in-list arr)])
      (begin
        (vector-set! prefix-xor i (xor (vector-ref prefix-xor (sub1 i)) x))
        (add1 i)))
    (for/list ([query (in-list queries)])
      (let ([l (list-ref query 0)]
            [r (list-ref query 1)])
        (xor (vector-ref prefix-xor (add1 r)) (vector-ref prefix-xor l))))))