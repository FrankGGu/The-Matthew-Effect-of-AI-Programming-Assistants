(define (max-repeating sequence word)
  (define (helper k)
    (let ((s (make-string k word)))
    (if (string-contains? sequence s)
        (helper (+ k 1))
        (- k 1)))
  (if (string=? word "")
      0
      (helper 1)))