(define (doesNotNeedExtraZeroes nums)
  (let* ((n (length nums))
         (a (make-vector n 0)))
    (vector-set! a 0 0)
    (for/fold ((valid? #t))
              ((i (in-range 1 n)))
      (if valid?
          (let ((b (vector-xor (list (vector-ref nums (sub1 i))) (list (vector-ref a (sub1 i))))))
            (vector-set! a i (car b))
            #t)
          #f))
    (if (and valid? (= (vector-ref a 0) (vector-xor (list (vector-ref nums 0)) (list (vector-ref a (sub1 n))))))
        #t
        #f)))