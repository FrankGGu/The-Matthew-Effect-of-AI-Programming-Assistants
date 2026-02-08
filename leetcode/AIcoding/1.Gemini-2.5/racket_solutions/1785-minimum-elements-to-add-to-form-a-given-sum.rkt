(define (min-elements nums limit goal)
  (let* ((current-sum (apply + nums))
         (diff (abs (- goal current-sum))))
    (ceiling (/ diff limit))))