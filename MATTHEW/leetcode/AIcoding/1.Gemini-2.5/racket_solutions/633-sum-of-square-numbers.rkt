(define (check-sum-of-square-numbers c)
  (let loop ((a 0))
    (let* ((a-squared (* a a)))
      (cond
        ((> a-squared c) #f)
        (else
         (let* ((b-squared (- c a-squared)))
           (let ((b (exact-floor (sqrt b-squared))))
             (if (= (* b b) b-squared)
                 #t
                 (loop (+ a 1))))))))))