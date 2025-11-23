(define/contract (maximum-length nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([i 0] [j 0] [sum 0] [max-len 0] [nums nums])
    (cond
      [(>= j (length nums)) max-len]
      [(<= (+ sum (list-ref nums j)) k)
       (loop i (+ j 1) (+ sum (list-ref nums j)) (max max-len (- (+ j 1) i))]
      [else
       (loop (+ i 1) j (- sum (list-ref nums i)) max-len nums)])))