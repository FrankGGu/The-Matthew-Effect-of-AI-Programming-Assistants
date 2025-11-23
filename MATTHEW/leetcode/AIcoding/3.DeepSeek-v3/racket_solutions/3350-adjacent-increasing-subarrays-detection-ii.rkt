(define/contract (can-increase-subarrays nums)
  (-> (listof exact-integer?) boolean?)
  (let loop ((i 0) (n (length nums)))
    (cond
      [(>= i (- n 1)) #t]
      [(> (list-ref nums i) (list-ref nums (+ i 1))) #f]
      [else (loop (+ i 1) n)])))