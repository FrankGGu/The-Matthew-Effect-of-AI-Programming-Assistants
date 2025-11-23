(define/contract (count-happy-students nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted-nums (sort nums <)]
         [n (length sorted-nums)]
         [happy 0])
    (for ([i (in-range n)]
          #:when (and (< (list-ref sorted-nums i) (add1 i))
                      (or (= i (sub1 n))
                          (> (list-ref sorted-nums (add1 i)) (add1 i)))))
      (set! happy (add1 happy)))
    happy))