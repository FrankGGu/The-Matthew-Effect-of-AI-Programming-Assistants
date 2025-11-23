(define (minOperations nums)
  (let* ((min-val (apply min nums))
         (operations (foldl (lambda (x acc) (+ acc (- x min-val))) 0 nums)))
    operations))