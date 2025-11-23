(define/contract (total-steps nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [steps 0] [changed #f] [prev -inf.0] [res '()])
    (cond
      [(null? nums) (if changed (loop (reverse res) (add1 steps) #f -inf.0 '()) steps)]
      [(> (car nums) prev) (loop (cdr nums) steps changed (car nums) (cons (car nums) res))]
      [else (loop (cdr nums) steps #t prev res)])))