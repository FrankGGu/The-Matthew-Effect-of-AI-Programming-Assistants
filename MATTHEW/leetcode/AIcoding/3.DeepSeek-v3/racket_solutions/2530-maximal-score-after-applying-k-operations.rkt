(define/contract (max-kelements nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums (sort nums >)] [k k] [score 0])
    (if (zero? k)
        score
        (let* ([max-num (first nums)]
               [new-nums (cons (ceiling (/ max-num 3)) (rest nums)]))
          (loop (sort new-nums >) (sub1 k) (+ score max-num)))))