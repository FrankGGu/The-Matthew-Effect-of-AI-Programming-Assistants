(define (sorted-squares nums)
  (let* ((n (length nums))
         (result (make-vector n)))
    (let loop ((left 0) (right (- n 1)) (index (- n 1)))
      (cond
        ((< left right)
         (let ((left-sqr (expt (vector-ref nums left) 2))
               (right-sqr (expt (vector-ref nums right) 2)))
           (if (> left-sqr right-sqr)
               (begin
                 (vector-set! result index left-sqr)
                 (loop (+ left 1) right (- index 1)))
               (begin
                 (vector-set! result index right-sqr)
                 (loop left (- right 1) (- index 1))))))
        ((= left right)
         (vector-set! result index (expt (vector-ref nums left) 2)))
        (else
         result)))))