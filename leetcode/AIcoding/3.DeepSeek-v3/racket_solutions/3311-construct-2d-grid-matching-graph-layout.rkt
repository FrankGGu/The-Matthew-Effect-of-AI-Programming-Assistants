(define/contract (shift-grid grid k)
  (-> (listof (listof exact-integer?)) exact-integer? (listof (listof exact-integer?)))
  (let* ([m (length grid)]
         [n (if (null? grid) 0 (length (car grid)))]
         [total (* m n)]
         [k (modulo k total)]
         [flattened (apply append grid)]
         [shifted (append (take-right flattened k) (drop-right flattened k))])
    (for/list ([i (in-range m)])
      (for/list ([j (in-range n)])
        (list-ref shifted (+ (* i n) j))))))