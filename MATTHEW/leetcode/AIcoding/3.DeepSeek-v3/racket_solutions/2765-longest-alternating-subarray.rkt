(define/contract (alternating-subarray nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [max-len 0] [current-len 1])
    (cond
      [(>= i (sub1 (length nums))) max-len]
      [(= (list-ref nums (add1 i)) (+ (list-ref nums i) (if (even? current-len) -1 1)))
       (loop (add1 i) (max max-len (add1 current-len)) (add1 current-len))]
      [else (loop (add1 i) (max max-len current-len) 1]))))