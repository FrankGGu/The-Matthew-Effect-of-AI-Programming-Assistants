(define/contract (find-middle-index nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (helper left-sum right-sum i)
    (cond
      [(= left-sum right-sum) i]
      [(>= i (length nums)) -1]
      [else (helper (+ left-sum (list-ref nums i)) 
                    (- right-sum (list-ref nums (add1 i))) 
                    (add1 i))]))
  (define total-sum (apply + nums))
  (if (null? nums) 
      -1
      (helper 0 (- total-sum (car nums)) 0)))