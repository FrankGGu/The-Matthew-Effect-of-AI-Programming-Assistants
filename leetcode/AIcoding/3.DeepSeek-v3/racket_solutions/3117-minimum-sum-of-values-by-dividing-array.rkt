(define/contract (minimum-sum nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums (sort nums >)] [k k])
    (if (zero? k)
        (apply + nums)
        (let* ([max-num (first nums)]
               [new-num (ceiling (/ max-num 2))]
               [new-nums (cons new-num (rest nums))])
          (loop (sort new-nums >) (sub1 k))))))