(define/public (generateParenthesis n)
  (define (backtrack current-string open-count close-count)
    (cond
      ;; Base case: A valid combination is found when both open and close counts reach n
      ((and (= open-count n) (= close-count n))
       (list current-string)) ; Return a list containing just this string

      ;; Recursive step: Explore possibilities
      (else
       (let* ((res-open  (if (< open-count n)
                             ;; If we can add an opening parenthesis, do so and recurse
                             (backtrack (string-append current-string "(") (+ open-count 1) close-count)
                             '())) ; Otherwise, no results from this branch
              (res-close (if (< close-count open-count)
                             ;; If we can add a closing parenthesis (only if open count is greater), do so and recurse
                             (backtrack (string-append current-string ")") open-count (+ close-count 1))
                             '()))) ; Otherwise, no results from this branch
         ;; Combine results from both branches
         (append res-open res-close)))))

  ;; Start the backtracking process with an empty string, zero open, and zero close parentheses
  (backtrack "" 0 0))