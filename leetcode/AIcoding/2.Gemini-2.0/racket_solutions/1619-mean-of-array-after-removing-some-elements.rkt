(define (trim-mean arr)
  (let* ([n (length arr)]
         [five-percent (floor (* n 0.05))]
         [sorted-arr (sort arr <)]
         [trimmed-arr (drop (take sorted-arr (- n (* 2 five-percent))) five-percent)]
         [sum (apply + trimmed-arr)]
         [trimmed-n (length trimmed-arr)])
    (/ sum trimmed-n)))