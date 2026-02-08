(define (findClosestNumber nums)
  (foldl (lambda (x acc)
            (cond
              [(= (abs x) (abs acc)) (if (> x acc) acc x)]
              [(< (abs x) (abs acc)) x]
              [else acc]))
          (car nums)
          nums))

(findClosestNumber (list -1 2 -3 4 5))