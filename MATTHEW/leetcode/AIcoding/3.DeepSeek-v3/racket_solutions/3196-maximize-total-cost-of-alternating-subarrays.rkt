(define/contract (maximum-total-cost nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [prev-sign 1] [sum 0])
    (if (>= i (length nums))
        sum
        (let* ([current (list-ref nums i)]
               [new-sum (+ sum (* prev-sign current))])
          (max (loop (+ i 1) 1 new-sum)
               (loop (+ i 1) -1 new-sum))))))