(define/contract (largest-sum-after-k-negations nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums (sort nums <)] [k k])
    (cond
      [(or (null? nums) (zero? k)) (apply + nums)]
      [(< (car nums) 0)
       (loop (cons (- (car nums)) (cdr nums)) (sub1 k))]
      [else
       (if (even? k)
           (apply + nums)
           (apply + (cons (- (car nums)) (cdr nums))))])))