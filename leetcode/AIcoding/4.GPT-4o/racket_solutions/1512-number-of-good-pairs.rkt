(define (numIdenticalPairs nums)
  (define (count-pairs lst)
    (let loop ((lst lst) (counts '()))
      (if (null? lst)
          counts
          (let* ((x (car lst))
                 (count (length (filter (lambda (y) (= x y)) lst)))
                 (pairs (/ (* count (- count 1)) 2)))
            (loop (cdr lst) (cons pairs counts)))))
  (apply + (count-pairs nums)))

(define (numIdenticalPairs-entry nums)
  (numIdenticalPairs nums))