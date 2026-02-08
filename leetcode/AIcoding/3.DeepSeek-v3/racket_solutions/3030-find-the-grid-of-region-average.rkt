(define/contract (image-smoother img)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (define m (length img))
  (define n (if (zero? m) 0 (length (car img))))
  (define (get-average i j)
    (let loop ([x (max 0 (sub1 i))] [y (max 0 (sub1 j))] [sum 0] [count 0])
      (cond
        [(> x (min (sub1 m) (add1 i))) (quotient sum count)]
        [(> y (min (sub1 n) (add1 j))) (loop (add1 x) (max 0 (sub1 j)) sum count)]
        [else (loop x (add1 y) (+ sum (list-ref (list-ref img x) y)) (add1 count))])))
  (for/list ([i (in-range m)])
    (for/list ([j (in-range n)])
      (get-average i j))))