(define (max-ascending-sum nums)
  (define (helper current-sum max-sum prev i)
    (cond
      [(= i (length nums)) (max current-sum max-sum)]
      [(> (list-ref nums i) prev) (helper (+ current-sum (list-ref nums i)) 
                                          (max max-sum (+ current-sum (list-ref nums i))) 
                                          (list-ref nums i) 
                                          (+ i 1))]
      [else (helper (list-ref nums i) 
                    (max max-sum current-sum) 
                    (list-ref nums i) 
                    (+ i 1))]))
  (if (null? nums) 
      0 
      (helper (car nums) (car nums) (car nums) 1)))