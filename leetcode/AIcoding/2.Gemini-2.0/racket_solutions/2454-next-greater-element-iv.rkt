(define (next-greater-elements-iv nums)
  (let* ((n (length nums))
         (res (make-vector n -1))
         (stack (list))
         (second-greater (make-vector n -1)))
    (for ((i (in-range n)))
      (let loop ((st stack))
        (cond
          ((null? st) (set! stack (cons i st)))
          ((< (vector-ref nums (car st)) (vector-ref nums i))
           (begin
             (set! second-greater (vector-set second-greater (car st) i))
             (loop (cdr st))))
          (else (set! stack (cons i st))))))

    (let ((stack (list)))
      (for ((i (in-range n)))
        (let loop ((st stack))
          (cond
            ((null? st) (set! stack (cons i st)))
            ((< (vector-ref nums (car st)) (vector-ref nums i))
             (begin
               (let ((second-index (vector-ref second-greater (car st))))
                 (when (and (>= second-index 0) (< (vector-ref nums second-index) (vector-ref nums i)))
                   (vector-set! res (car st) (vector-ref nums i))))
               (loop (cdr st))))
            (else (set! stack (cons i st))))))
    (vector->list res)))