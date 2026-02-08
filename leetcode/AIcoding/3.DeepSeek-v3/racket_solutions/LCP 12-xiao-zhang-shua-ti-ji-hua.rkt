(define/contract (min-time time m)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (can-finish? days)
    (let loop ([i 0] [sum 0] [max-t 0] [day 1])
      (cond
        [(= i (length time)) (<= day days)]
        [(> day days) #f]
        [else
         (let* ([t (list-ref time i)]
                [new-sum (+ sum t)]
                [new-max (max max-t t)])
           (if (> new-sum (* days new-max))
               (loop (add1 i) t t (add1 day))
               (loop (add1 i) new-sum new-max day)))])))
  (let binary-search ([left 1] [right (apply + time)])
    (if (>= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (can-finish? mid)
              (binary-search left mid)
              (binary-search (add1 mid) right))))))