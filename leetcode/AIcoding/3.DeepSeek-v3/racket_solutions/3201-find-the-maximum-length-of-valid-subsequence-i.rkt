(define/contract (maximum-length nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums nums]
             [start 0]
             [current 0]
             [max-len 0]
             [sum 0])
    (cond
      [(null? nums) max-len]
      [(> (+ sum (car nums)) k)
       (loop (cdr nums) (add1 start) (sub1 current) max-len (- sum (list-ref nums start)))]
      [else
       (let* ([new-sum (+ sum (car nums))]
              [new-current (add1 current)]
              [new-max-len (max max-len new-current)])
         (loop (cdr nums) start new-current new-max-len new-sum))])))