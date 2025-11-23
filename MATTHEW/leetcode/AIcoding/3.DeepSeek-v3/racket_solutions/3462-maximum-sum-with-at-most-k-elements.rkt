(define/contract (maximize-sum nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([max-num (apply max nums)]
         [sum (* k max-num)]
         [sum (+ sum (/ (* k (- k 1)) 2))])
    sum))