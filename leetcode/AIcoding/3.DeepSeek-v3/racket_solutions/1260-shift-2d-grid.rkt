(define/contract (shift-grid grid k)
  (-> (listof (listof exact-integer?)) exact-integer? (listof (listof exact-integer?)))
  (let* ([m (length grid)]
         [n (length (car grid))]
         [total (* m n)]
         [k (modulo k total)]
         [flattened (apply append grid)]
         [shifted (append (drop flattened (- total k)) (take flattened (- total k)))])
    (for/list ([i (in-range m)])
      (for/list ([j (in-range n)])
        (list-ref shifted (+ (* i n) j))))))