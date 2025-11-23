(define/contract (can-jump nums)
  (-> (listof exact-integer?) boolean?)
  (let loop ([pos 0] [max-reach 0])
    (cond
      [(>= pos (sub1 (length nums))) #t]
      [(> pos max-reach) #f]
      [else (loop (add1 pos) (max max-reach (+ pos (list-ref nums pos))))])))