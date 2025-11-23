(define (max-ascending-subarray-sum nums)
  (let loop ([nums nums]
             [current-sum 0]
             [max-sum 0])
    (cond
      [(empty? nums)
       (max max-sum current-sum)]
      [(or (= current-sum 0)
           (> (car nums) current-sum-prev))
       (loop (cdr nums) (+ current-sum (car nums)) (max max-sum (+ current-sum (car nums))))]
      [else
       (loop (cdr nums) (car nums) (max max-sum current-sum))]))
  (let ([n (length nums)])
    (if (= n 0)
        0
        (let loop ([i 0]
                   [current-sum (list-ref nums 0)]
                   [max-sum (list-ref nums 0)])
          (if (= i (- n 1))
              max-sum
              (let ([next-val (list-ref nums (+ i 1))])
                (if (> next-val (list-ref nums i))
                    (loop (+ i 1) (+ current-sum next-val) (max max-sum (+ current-sum next-val)))
                    (loop (+ i 1) next-val (max max-sum next-val)))))))))