(define/contract (minimal-k-sum nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums (sort nums <)]
             [prev 0]
             [remaining k]
             [sum 0])
    (cond
      [(or (null? nums) (zero? remaining))
       (if (zero? remaining)
           sum
           (let ([n (+ prev remaining)])
             (+ sum (/ (* n (+ n 1)) 2) (/ (* prev (+ prev 1)) 2 -1))))]
      [else
       (let ([curr (car nums)])
         (if (<= curr prev)
             (loop (cdr nums) prev remaining sum)
             (let ([available (- curr prev 1)])
               (if (>= available remaining)
                   (let ([end (+ prev remaining)])
                     (+ sum (/ (* end (+ end 1)) 2) (/ (* prev (+ prev 1)) 2 -1)))
                   (loop (cdr nums)
                         curr
                         (- remaining available)
                         (+ sum (/ (* curr (+ curr 1)) 2) (/ (* (+ prev 1) (+ prev 2)) 2 -1)))))))]))))