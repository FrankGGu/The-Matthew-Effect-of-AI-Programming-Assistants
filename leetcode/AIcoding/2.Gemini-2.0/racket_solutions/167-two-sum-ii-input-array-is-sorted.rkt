(define (two-sum-ii nums target)
  (let loop ([left 0] [right (- (length nums) 1)])
    (cond
      [(>= left right) '()]
      [(< (+ (list-ref nums left) (list-ref nums right)) target)
       (loop (+ left 1) right)]
      [(> (+ (list-ref nums left) (list-ref nums right)) target)
       (loop left (- right 1))]
      [else
       (list (+ left 1) (+ right 1))])))