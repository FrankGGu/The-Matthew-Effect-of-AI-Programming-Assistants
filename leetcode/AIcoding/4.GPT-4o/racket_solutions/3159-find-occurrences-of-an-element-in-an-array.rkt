(define (countOccurrences nums target)
  (foldl (lambda (x acc) (if (= x target) (+ acc 1) acc)) 0 nums))