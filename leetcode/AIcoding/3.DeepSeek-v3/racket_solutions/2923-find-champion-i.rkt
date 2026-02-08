(define/contract (find-champion grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let loop ([i 0] [n (length grid)])
    (cond
      [(= i n) -1]
      [(andmap (lambda (x) (or (equal? i x) (= (list-ref (list-ref grid x) i) 0))) (range n)) i]
      [else (loop (add1 i) n)])))