(define/contract (mirror-reflection p q)
  (-> exact-integer? exact-integer? exact-integer?)
  (let loop ([p p] [q q])
    (cond
      [(even? p) (loop (/ p 2) q)]
      [(even? q) (loop p (/ q 2))]
      [else (if (= (modulo q p) 0)
                (if (even? (/ q p)) 2 1)
                0)])))