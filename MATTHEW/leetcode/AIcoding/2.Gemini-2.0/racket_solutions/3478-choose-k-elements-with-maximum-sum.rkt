(define (max-sum k nums numNeg numPos)
  (let loop ((i 0) (sum 0) (k k))
    (cond
      ((= k 0) sum)
      ((= i (length nums)) sum)
      (else
       (let ((num (list-ref nums i)))
         (if (> num 0)
             (loop (+ i 1) (+ sum num) (- k 1))
             (loop (+ i 1) sum k)))))))

(define (maximize-sum nums k)
  (let* ((numPos (length (filter positive? nums)))
         (numNeg (length (filter negative? nums)))
         (numZero (length (filter zero? nums))))
    (cond
      ((<= k numPos) k)
      ((<= (+ numPos numZero) k) numPos)
      (else numPos))))