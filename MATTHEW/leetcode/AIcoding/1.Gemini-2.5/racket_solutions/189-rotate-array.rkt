(define (rotate nums k)
  (let* ((n (length nums))
         (k-effective (if (= n 0) 0 (modulo k n))))
    (if (= k-effective 0)
        nums
        (let ((split-index (- n k-effective)))
          (append (drop nums split-index)
                  (take nums split-index))))))