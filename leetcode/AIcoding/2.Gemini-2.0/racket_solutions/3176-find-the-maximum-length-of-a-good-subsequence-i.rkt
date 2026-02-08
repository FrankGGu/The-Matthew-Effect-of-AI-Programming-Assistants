(define (max-length-good-subsequence nums k)
  (define (helper nums current-subsequence)
    (cond
      [(empty? nums)
       (if (good-subsequence? current-subsequence k)
           (length current-subsequence)
           0)]
      [else
       (max (helper (cdr nums) current-subsequence)
            (helper (cdr nums) (append current-subsequence (list (car nums)))))]))

  (define (good-subsequence? subsequence k)
    (if (empty? subsequence)
        #t
        (<= (apply + subsequence) k)))

  (helper nums '()))