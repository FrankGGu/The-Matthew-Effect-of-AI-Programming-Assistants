(define (min-elements nums limit goal)
  (let ((sum (apply + nums)))
    (ceiling (abs (- goal sum)) limit)))