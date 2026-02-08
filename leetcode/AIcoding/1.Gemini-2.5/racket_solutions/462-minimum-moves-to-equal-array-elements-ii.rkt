(define (min-moves2 nums)
  (let* ([n (length nums)]
         [sorted-nums (sort nums <)]
         [median (list-ref sorted-nums (floor (/ n 2)))])
    (for/sum ([num sorted-nums])
      (abs (- num median)))))