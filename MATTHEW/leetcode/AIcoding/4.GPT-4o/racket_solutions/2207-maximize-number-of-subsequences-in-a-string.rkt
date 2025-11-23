(define (maximumSubsequenceCount text pattern)
  (let* ((count-a (string-count text (string-ref pattern 0)))
         (count-b (string-count text (string-ref pattern 1)))
         (total (+ count-a count-b))
         (max-count (max count-a count-b)))
    (if (equal? count-a count-b)
        (+ total 1)
        total)))

(maximumSubsequenceCount "abdcabc" "ab") ; Example function call