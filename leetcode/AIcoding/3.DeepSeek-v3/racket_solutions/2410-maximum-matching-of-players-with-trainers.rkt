(define/contract (match-players-and-trainers players trainers)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let ([sorted-players (sort players <)]
        [sorted-trainers (sort trainers <)]
        [i 0]
        [j 0]
        [count 0])
    (let loop ([i i] [j j] [count count])
      (cond
        [(or (>= i (length sorted-players)) (>= j (length sorted-trainers))] count)
        [(>= j (length sorted-trainers)) count]
        [(<= (list-ref sorted-players i) (list-ref sorted-trainers j))
         (loop (add1 i) (add1 j) (add1 count))]
        [else (loop i (add1 j) count)]))))