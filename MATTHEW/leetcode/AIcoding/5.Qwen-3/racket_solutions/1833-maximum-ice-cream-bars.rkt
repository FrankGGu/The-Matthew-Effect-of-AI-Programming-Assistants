(define/contract (max-ice-cream cost)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([cost (sort cost <)] [budget 0] [count 0])
    (cond
      [(null? cost) count]
      [(<= (car cost) budget)
       (loop (cdr cost) (- budget (car cost)) (+ count 1))]
      [else count])))