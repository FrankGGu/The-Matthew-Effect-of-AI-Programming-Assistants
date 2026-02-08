(define/contract (min-moves2 nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted-nums (sort nums <)]
         [median (list-ref sorted-nums (quotient (length sorted-nums) 2))]
         [moves (for/sum ([num sorted-nums]) (abs (- num median)))])
    moves))