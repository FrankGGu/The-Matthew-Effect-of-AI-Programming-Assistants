(define/contract (maximum-operations nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right (sub1 (length nums))] [ops 0])
    (cond
      [(>= left right) ops]
      [(= (list-ref nums left) 1)
       (loop (add1 left) right ops)]
      [(= (list-ref nums right) 0)
       (loop left (sub1 right) ops)]
      [else
       (loop (add1 left) (sub1 right) (add1 ops))])))