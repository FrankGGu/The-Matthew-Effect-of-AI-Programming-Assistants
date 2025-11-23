(define (k-strongest-values arr k)
  (let* ((n (length arr))
         (sorted-arr (sort arr <))
         (m (list-ref sorted-arr (quotient (- n 1) 2))))

    (define (stronger? a b)
      (let* ((diff-a (abs (- a m)))
             (diff-b (abs (- b m))))
        (cond
          ((> diff-a diff-b) #t)
          ((< diff-a diff-b) #f)
          (else (> a b)))))

    (let ((strength-sorted-arr (sort arr stronger?)))
      (take strength-sorted-arr k))))