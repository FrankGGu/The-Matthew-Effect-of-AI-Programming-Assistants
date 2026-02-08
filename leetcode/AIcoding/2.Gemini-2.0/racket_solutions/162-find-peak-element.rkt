(define (find-peak-element nums)
  (let loop ((l 0) (r (- (length nums) 1)))
    (cond
      [(>= l r) l]
      [else
       (let ((mid (quotient (+ l r) 2)))
         (if (> (list-ref nums mid) (list-ref nums (+ mid 1)))
             (loop l mid)
             (loop (+ mid 1) r)))])))