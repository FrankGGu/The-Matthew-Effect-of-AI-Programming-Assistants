(define/contract (sort-array-by-parity-ii nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let loop ([evens (filter even? nums)]
             [odds (filter odd? nums)]
             [result '()]
             [even? #t])
    (cond
      [(and (null? evens) (null? odds)) (reverse result)]
      [even? (loop (cdr evens) odds (cons (car evens) result) #f)]
      [else (loop evens (cdr odds) (cons (car odds) result) #t)])))