(define (minimumTimeToRevert words)
  (define (helper w)
    (foldl (lambda (x acc) (if (equal? x #\.) acc (+ acc 1))) 0 w))
  (define total (foldl (lambda (x acc) (+ acc (helper x))) 0 words))
  total)

(define (minimumTimeToRevertWord words)
  (minimumTimeToRevert words))