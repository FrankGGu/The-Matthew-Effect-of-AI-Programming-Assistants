(define (apply-operations nums k)
  (let loop ([nums nums] [i 0] [curr-sum 0])
    (cond
      [(>= i (length nums)) (= curr-sum 0)]
      [else
       (let ([diff (- (list-ref nums i) curr-sum)])
         (cond
           [(< diff 0) #f]
           [else
            (let ([new-sum (+ curr-sum diff)])
              (loop nums (+ i 1) new-sum))]))])))