(define (find-minimum-log-transportation-cost positions)
  (let ((n (length positions)))
    (if (zero? n)
        0
        (let* ((sorted-positions (sort positions <))
               (median-index (quotient n 2))
               (median-position (list-ref sorted-positions median-index)))
          (foldl (lambda (pos current-sum)
                   (+ current-sum (abs (- pos median-position))))
                 0
                 sorted-positions)))))