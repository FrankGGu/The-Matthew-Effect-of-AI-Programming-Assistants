(define (minimum-operations nums)
  (let loop ((numbers nums) (operations 0))
    (cond
      ((empty? numbers) operations)
      (else
       (let ((num (first numbers)))
         (loop (rest numbers)
               (+ operations (if (= (remainder num 3) 0) 0 1))))))))