(define (minimum-amount-of-time-to-fill-cups cups)
  (let* ((sorted-cups (sort cups >))
         (largest (list-ref sorted-cups 0))
         (second-largest (list-ref sorted-cups 1))
         (smallest (list-ref sorted-cups 2)))
    (if (> largest (+ second-largest smallest))
        largest
        (ceiling (/ (+ largest second-largest smallest) 2.0)))))