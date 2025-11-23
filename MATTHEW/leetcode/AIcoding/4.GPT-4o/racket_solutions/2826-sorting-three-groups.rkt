(define (sortThreeGroups nums)
  (let loop ((nums nums) (zeroes '()) (ones '()) (twos '()))
    (cond
      ((null? nums) (append zeroes ones twos))
      ((= (car nums) 0) (loop (cdr nums) (cons 0 zeroes) ones twos))
      ((= (car nums) 1) (loop (cdr nums) zeroes (cons 1 ones) twos))
      ((= (car nums) 2) (loop (cdr nums) zeroes ones (cons 2 twos))))))