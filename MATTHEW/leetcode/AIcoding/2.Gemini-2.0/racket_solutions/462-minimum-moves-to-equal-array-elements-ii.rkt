(define (min-moves2 nums)
  (let* ([sorted-nums (sort nums <)]
         [median (list-ref sorted-nums (quotient (length sorted-nums) 2))])
    (foldl (lambda (x acc) (+ acc (abs (- x median)))) 0 sorted-nums)))