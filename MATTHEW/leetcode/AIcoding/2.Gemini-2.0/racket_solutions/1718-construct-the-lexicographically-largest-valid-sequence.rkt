(define (construct-distanced-sequence n)
  (let* ((ans (make-vector (* 2 n - 1) 0))
         (used (make-vector (add1 n) #f))
         (len (vector-length ans)))
    (define (backtrack idx)
      (cond ((= idx len) #t)
            ((not (= (vector-ref ans idx) 0)) (backtrack (add1 idx)))
            (else
             (let loop ((num n))
               (cond ((zero? num) #f)
                     ((vector-ref used num) (loop (sub1 num)))
                     (else
                      (let ((next-idx (+ idx num)))
                        (cond ((and (<= next-idx (- len 1)) (= (vector-ref ans next-idx) 0))
                              (begin
                                (vector-set! ans idx num)
                                (vector-set! ans next-idx num)
                                (vector-set! used num #t)
                                (if (backtrack (add1 idx))
                                    #t
                                    (begin
                                      (vector-set! ans idx 0)
                                      (vector-set! ans next-idx 0)
                                      (vector-set! used num #f)
                                      (loop (sub1 num)))))
                              (if (= num 1)
                                  (begin
                                    (vector-set! ans idx num)
                                    (vector-set! used num #t)
                                    (if (backtrack (add1 idx))
                                        #t
                                        (begin
                                          (vector-set! ans idx 0)
                                          (vector-set! used num #f)
                                          (loop (sub1 num)))))
                                  (loop (sub1 num)))))))))))
    (backtrack 0)
    (list->vector (vector->list ans))))