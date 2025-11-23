(define/contract (large-group-positions s)
  (-> string? (listof (listof exact-integer?)))
  (let loop ([i 0] [j 0] [res '()])
    (cond
      [(>= j (string-length s))
       (if (>= (- j i) 3)
           (reverse (cons (list i (sub1 j)) res))
           (reverse res))]
      [(char=? (string-ref s i) (string-ref s j))
       (loop i (add1 j) res)]
      [else
       (if (>= (- j i) 3)
           (loop j j (cons (list i (sub1 j)) res))
           (loop j j res))])))