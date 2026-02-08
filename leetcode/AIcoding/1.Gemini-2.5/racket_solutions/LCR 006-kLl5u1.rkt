(define (two-sum numbers target)
  (let loop ((left 0) (right (- (vector-length numbers) 1)))
    (let* ((num1 (vector-ref numbers left))
           (num2 (vector-ref numbers right))
           (current-sum (+ num1 num2)))
      (cond
        ((= current-sum target) (list (+ left 1) (+ right 1)))
        ((< current-sum target) (loop (+ left 1) right))
        (else (loop left (- right 1)))))))