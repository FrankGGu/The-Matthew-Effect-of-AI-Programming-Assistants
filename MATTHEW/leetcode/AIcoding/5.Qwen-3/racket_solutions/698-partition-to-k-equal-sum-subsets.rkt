(define (can-partition-k-equal-sum-subsets nums k)
  (let* ((n (length nums))
         (sum (apply + nums))
         (target (/ sum k)))
    (if (or (not (integer? target)) (> k n))
        #f
        (let ((nums (sort nums >)))
          (let ((used (make-vector n #f)))
            (define (backtrack pos count)
              (cond ((= count k) #t)
                    ((= pos n) #f)
                    (else
                     (let ((current (vector-ref used pos)))
                       (if current
                           (backtrack (+ pos 1) count)
                           (let ((new-sum (+ (list-ref nums pos) (if (= count 0) 0 (apply + (filter (lambda (i) (vector-ref used i)) (map (lambda (x) x) (range 0 n))))))))
                             (if (>= new-sum target)
                                 (begin
                                   (vector-set! used pos #t)
                                   (if (= new-sum target)
                                       (backtrack 0 (+ count 1))
                                       (begin
                                         (vector-set! used pos #f)
                                         #f)))
                                 (begin
                                   (vector-set! used pos #t)
                                   (if (backtrack (+ pos 1) count)
                                       #t
                                       (begin
                                         (vector-set! used pos #f)
                                         #f)))))))))
            (backtrack 0 0))))))