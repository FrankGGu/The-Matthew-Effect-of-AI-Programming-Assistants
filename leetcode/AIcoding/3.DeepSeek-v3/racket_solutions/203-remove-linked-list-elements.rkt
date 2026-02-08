(define/contract (remove-elements head val)
  (-> (or/c list-node? #f) exact-integer? (or/c list-node? #f))
  (let loop ([prev #f] [curr head])
    (cond
      [(not curr) (if prev (begin (set-list-node-next! prev #f) head) #f)]
      [(= (list-node-val curr) val)
       (if prev
           (begin (set-list-node-next! prev (list-node-next curr)) (loop prev (list-node-next curr)))
           (begin (set! head (list-node-next curr)) (loop #f head)))]
      [else (loop curr (list-node-next curr))])))