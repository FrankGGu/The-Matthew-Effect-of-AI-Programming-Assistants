(define (construct-sequence n)
  (let* ((arr (make-vector (* 2 n - 1) 0))
         (used (make-vector (add1 n) #f))
         (helper
          (lambda (index)
            (cond
              ((= index (vector-length arr)) #t)
              ((not (= (vector-ref arr index) 0)) (helper (add1 index)))
              (else
               (let loop ((num n))
                 (cond
                   ((zero? num) #f)
                   ((vector-ref used num) (loop (sub1 num)))
                   (else
                    (cond
                      ((and (= num 1) (not (= (vector-ref used num) #t)))
                       (begin
                         (vector-set! arr index num)
                         (vector-set! used num #t)
                         (if (helper (add1 index))
                             #t
                             (begin
                               (vector-set! arr index 0)
                               (vector-set! used num #f)
                               #f))))
                      ((and (<= (+ index num) (- (vector-length arr) 1))
                            (= (vector-ref arr (+ index num)) 0)
                            (not (= (vector-ref used num) #t)))
                       (begin
                         (vector-set! arr index num)
                         (vector-set! arr (+ index num) num)
                         (vector-set! used num #t)
                         (if (helper (add1 index))
                             #t
                             (begin
                               (vector-set! arr index 0)
                               (vector-set! arr (+ index num) 0)
                               (vector-set! used num #f)
                               #f))))
                      (else (loop (sub1 num)))))))))))))

    (helper 0)
    (list->vector (vector->list arr))))