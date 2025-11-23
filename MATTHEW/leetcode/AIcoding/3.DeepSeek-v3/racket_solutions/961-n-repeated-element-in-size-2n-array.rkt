(define/contract (repeated-n-times nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([seen (hash)])
    (cond
      [(hash-has-key? seen (car nums)) (car nums)]
      [else (loop (hash-set seen (car nums) #t) (cdr nums))])))