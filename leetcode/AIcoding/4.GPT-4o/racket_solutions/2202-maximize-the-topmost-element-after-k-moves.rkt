(define (maximize-the-top nums k)
  (let ((n (length nums)))
    (if (zero? n)
        0
        (let ((max-element (if (<= k n) (apply max (take nums k)) (apply max nums))))
          max-element))))