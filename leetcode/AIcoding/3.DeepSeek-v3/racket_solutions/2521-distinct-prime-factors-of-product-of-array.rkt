(define/contract (distinct-prime-factors nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (prime-factors n)
    (let loop ([n n] [i 2] [factors (set)])
      (cond
        [(= n 1) factors]
        [(> (* i i) n) (set-add factors n)]
        [(zero? (modulo n i)) (loop (/ n i) i (set-add factors i))]
        [else (loop n (+ i 1) factors)])))
  (define factors (mutable-set))
  (for ([num nums])
    (let ([pf (prime-factors num)])
      (set-union! factors pf)))
  (set-count factors))