(define/contract (split-array nums m)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (can-split max-sum)
    (let loop ([sum 0] [count 1] [nums nums])
      (cond
        [(null? nums) count]
        [(> (+ sum (car nums)) max-sum)
         (loop (car nums) (add1 count) (cdr nums))]
        [else (loop (+ sum (car nums)) count (cdr nums))])))

  (let binary-search ([left (apply max nums)] [right (apply + nums)])
    (if (= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (> (can-split mid) m)
              (binary-search (add1 mid) right)
              (binary-search left mid))))))