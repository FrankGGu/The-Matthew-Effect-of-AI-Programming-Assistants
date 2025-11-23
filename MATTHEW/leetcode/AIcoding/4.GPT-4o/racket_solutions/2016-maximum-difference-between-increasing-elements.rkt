(define (maximumDifference nums)
  (define (helper nums min-so-far max-diff)
    (if (null? nums)
        max-diff
        (let* ((current (car nums))
               (new-min (min min-so-far current))
               (new-diff (if (> current new-min)
                             (max max-diff (- current new-min))
                             max-diff)))
          (helper (cdr nums) new-min new-diff))))
  (let ((result (helper nums (car nums) -1)))
    (if (= result -1) -1 result)))

(maximumDifference '(7 1 5 4)) ; Example call, replace with actual inputs on LeetCode