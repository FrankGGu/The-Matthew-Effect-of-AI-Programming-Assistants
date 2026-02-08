(define/contract (find-content-children g s)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let ([sorted-g (sort g <)]
        [sorted-s (sort s <)])
    (let loop ([i 0] [j 0] [count 0])
      (cond
        [(or (>= i (length sorted-g)) (>= j (length sorted-s))] count)
        [(<= (list-ref sorted-g i) (list-ref sorted-s j)) (loop (+ i 1) (+ j 1) (+ count 1))]
        [else (loop i (+ j 1) count)]))))