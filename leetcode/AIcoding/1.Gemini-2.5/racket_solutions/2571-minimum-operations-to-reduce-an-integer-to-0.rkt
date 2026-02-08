(define (min-operations n)
  (let loop ((current-n n) (operations 0))
    (cond
      ((zero? current-n) operations)
      ((even? current-n) (loop (/ current-n 2) operations))
      (else ; current-n is odd
       (let ((remainder (modulo current-n 4)))
         (if (= remainder 1)
             (loop (/ (- current-n 1) 2) (+ operations 1))
             ; remainder must be 3
             (loop (/ (+ current-n 1) 2) (+ operations 1))))))))