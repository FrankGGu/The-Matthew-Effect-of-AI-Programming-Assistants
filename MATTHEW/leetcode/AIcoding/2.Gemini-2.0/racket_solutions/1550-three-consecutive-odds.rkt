(define (three-consecutive-odds nums)
  (cond
    [(< (length nums) 3) #f]
    [else
     (let loop ([i 0])
       (cond
         [(>= i (- (length nums) 2)) #f]
         [else
          (if (and (odd? (list-ref nums i))
                   (odd? (list-ref nums (+ i 1)))
                   (odd? (list-ref nums (+ i 2))))
              #t
              (loop (+ i 1))))]))))