(define (construct-maximum-binary-tree nums)
  (define (build nums left right)
    (if (> left right)
        null
        (let* ((max-index (argmax (λ (i) (list-ref nums i)) (range left (+ right 1))))
               (root (list (list-ref nums max-index) null null)))
          (list-set! root 1 (build nums left (- max-index 1)))
          (list-set! root 2 (build nums (+ max-index 1) right))
          root)))
  (build nums 0 (- (length nums) 1)))

(define (argmax f lst)
  (if (null? lst)
      #f
      (let loop ((lst (cdr lst))
                 (max-index 0)
                 (max-val (f (car lst)))
                 (index 1))
        (cond ((null? lst) max-index)
              (else
               (let ((val (f (car lst))))
                 (if (> val max-val)
                     (loop (cdr lst) index val (+ index 1))
                     (loop (cdr lst) max-index max-val (+ index 1)))))))))