(define (checkPalindromePartitioning s)
  (define (isPalindrome? str)
    (equal? str (string-reverse str)))

  (define (canPartition? start end)
    (if (>= start end)
        #t
        (if (isPalindrome? (substring s start end))
            (or (canPartition? (+ start 1) end)
                (canPartition? start (+ end 1)))
            (canPartition? (+ start 1) end))))

  (canPartition? 0 1))

(checkPalindromePartitioning "your_input_string")