(define/contract (min-increment-for-unique nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums (sort nums <)] [moves 0] [prev -1])
    (if (null? nums)
        moves
        (let* ([current (car nums)]
               [new-prev (if (> prev current) (add1 prev) current)]
               [new-moves (+ moves (- new-prev current))])
          (loop (cdr nums) new-moves new-prev)))))