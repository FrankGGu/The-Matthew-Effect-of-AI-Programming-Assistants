(define/contract (middle-node head)
  (-> (or/c list? null?) (or/c list? null?))
  (let loop ([slow head] [fast head])
    (cond
      [(or (null? fast) (null? (cdr fast))) slow]
      [else (loop (cdr slow) (cdr fast))])))