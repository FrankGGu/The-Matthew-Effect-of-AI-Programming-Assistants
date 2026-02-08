(define/contract (rob nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (helper nums prev curr)
    (if (null? nums)
        curr
        (helper (cdr nums) curr (max curr (+ prev (car nums))))))
  (if (null? nums)
      0
      (helper (cdr nums) 0 (car nums))))