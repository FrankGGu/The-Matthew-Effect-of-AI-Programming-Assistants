(define (min-swaps nums)
  (define n (length nums))
  (define ones (length (filter (lambda (x) (= x 1)) nums)))
  (define extended (append nums nums))
  (define max-ones-in-window (apply max (map (lambda (i) (apply + (sublist extended i (+ i ones)))) (range n))))
  (- ones max-ones-in-window))

(min-swaps (vector->list (vector 1 0 1 0 1)))