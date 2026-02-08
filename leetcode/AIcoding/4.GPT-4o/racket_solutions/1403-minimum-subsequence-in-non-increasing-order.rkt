(define (min-subsequence nums)
  (define total-sum (apply + nums))
  (define sorted-nums (sort nums >))
  (define (helper nums current-sum subsequence)
    (if (or (null? nums) (> current-sum (* total-sum 0.5)))
        subsequence
        (helper (cdr nums) (+ current-sum (car nums)) (cons (car nums) subsequence))))
  (helper sorted-nums 0 '()))

(define (minSubsequence nums)
  (min-subsequence nums))