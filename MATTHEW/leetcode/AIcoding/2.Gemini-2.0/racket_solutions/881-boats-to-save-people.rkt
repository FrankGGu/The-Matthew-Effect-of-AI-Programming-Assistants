(define (numRescueBoats people limit)
  (let* ([sorted-people (sort people >)]
         [left 0]
         [right (- (length sorted-people) 1)])
    (let loop ([left left] [right right] [count 0])
      (cond
        [(>= left right)
         (if (= left right)
             (+ count 1)
             count)]
        [(<= (+ (list-ref sorted-people left) (list-ref sorted-people right)) limit)
         (loop (+ left 1) (- right 1) (+ count 1))]
        [else
         (loop (+ left 1) right (+ count 1))]))))