(define/contract (check nums)
  (-> (listof exact-integer?) boolean?)
  (let* ([n (length nums)]
         [count 0])
    (for ([i (in-range n)])
      (when (> (list-ref nums (modulo i n))
               (list-ref nums (modulo (+ i 1) n)))
        (set! count (add1 count))))
    (<= count 1)))