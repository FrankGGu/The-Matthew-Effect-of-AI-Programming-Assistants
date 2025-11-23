(define/contract (distinct-averages nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums (sort nums <)]
             [seen (set)])
    (if (null? nums)
        (set-count seen)
        (let* ([min-num (car nums)]
               [max-num (last nums)]
               [avg (/ (+ min-num max-num) 2)])
          (loop (cdr (drop-right nums 1)) (set-add seen avg))))))