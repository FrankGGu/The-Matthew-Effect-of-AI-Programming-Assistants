(define/contract (largest-perimeter nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums (sort nums >)])
    (cond
      [(< (length nums) 3) 0]
      [(< (car (cdr nums)) (- (car nums) (car (cdr (cdr nums))))) (loop (cdr nums))]
      [else (+ (car nums) (car (cdr nums)) (car (cdr (cdr nums))))])))