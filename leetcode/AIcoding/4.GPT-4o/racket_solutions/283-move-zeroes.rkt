(define (move-zeroes nums)
  (define non-zeroes (filter (lambda (x) (not (= x 0))) nums))
  (define zero-count (- (length nums) (length non-zeroes)))
  (append non-zeroes (make-list zero-count 0)))

(move-zeroes '(0 1 0 3 12))