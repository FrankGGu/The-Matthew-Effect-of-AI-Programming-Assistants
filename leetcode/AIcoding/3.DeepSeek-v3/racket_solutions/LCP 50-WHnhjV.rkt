(define/contract (give-gem gem operations)
  (-> (listof exact-integer?) (listof (listof exact-integer?)) exact-integer?)
  (let loop ([gem gem] [ops operations])
    (if (null? ops)
        (- (apply max gem) (apply min gem))
        (let* ([op (car ops)]
               [giver (car op)]
               [receiver (cadr op)]
               [amount (quotient (list-ref gem giver) 2)])
          (loop (list-set (list-set gem giver (- (list-ref gem giver) amount))
                          receiver (+ (list-ref gem receiver) amount))
                (cdr ops))))))