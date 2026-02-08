(define (find-largest-almost-missing-integer nums)
  (let* ((n (length nums))
         (present? (make-vector (add1 n) #f)))
    (for ([num nums])
      (when (and (positive? num) (<= num n))
        (vector-set! present? num #t)))
    (let loop ([i n])
      (cond
        [(zero? i) 0]
        [(vector-ref present? i) (loop (sub1 i))]
        [else i]))))