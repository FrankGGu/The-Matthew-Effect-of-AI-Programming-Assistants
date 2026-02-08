(define/contract (minimum-coins fruits)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [cost 0] [free 0] [n (length fruits)])
    (cond
      [(>= i n) cost]
      [else
       (if (> free 0)
           (loop (add1 i) cost (sub1 free) n)
           (let ([j (min (+ i 1) (sub1 n))])
             (loop (add1 j) (+ cost (list-ref fruits j)) (+ (- j i) 1) n)))])))