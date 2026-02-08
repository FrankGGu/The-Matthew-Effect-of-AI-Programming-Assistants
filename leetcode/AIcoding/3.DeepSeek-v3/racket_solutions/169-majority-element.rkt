(define/contract (majority-element nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([count 0] [candidate 0] [nums nums])
    (cond
      [(null? nums) candidate]
      [(zero? count) (loop 1 (car nums) (cdr nums))]
      [(= (car nums) candidate) (loop (add1 count) candidate (cdr nums))]
      [else (loop (sub1 count) candidate (cdr nums))])))