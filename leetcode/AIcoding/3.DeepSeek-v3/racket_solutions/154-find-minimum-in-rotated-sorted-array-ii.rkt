(define/contract (find-min nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right (sub1 (length nums))])
    (cond
      [(>= left right) (list-ref nums left)]
      [(< (list-ref nums left) (list-ref nums right)) (list-ref nums left)]
      [else
       (let ([mid (quotient (+ left right) 2)])
         (cond
           [(< (list-ref nums mid) (list-ref nums right)) (loop left mid)]
           [(> (list-ref nums mid) (list-ref nums right)) (loop (add1 mid) right)]
           [else (loop left (sub1 right))]))])))