(define (minOperations grid x)
  (let* ((rows (length grid))
         (cols (length (car grid)))
         (nums (flatten grid))
         (n (length nums)))
    (cond
      [(not (for/and ([i (in-range n)] [j (in-range (+ i 1 n))])
              (equal? (modulo (- (list-ref nums i) (list-ref nums j)) x) 0)))
       -1]
      [else
       (let* ((sorted-nums (sort nums <))
              (median (list-ref sorted-nums (quotient n 2))))
         (for/sum ([num (in-list nums)])
           (quotient (abs (- num median)) x)))])))