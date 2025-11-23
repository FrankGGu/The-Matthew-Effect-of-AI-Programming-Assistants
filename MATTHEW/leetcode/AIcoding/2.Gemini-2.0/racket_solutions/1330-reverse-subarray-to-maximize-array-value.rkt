(define (abs x)
  (if (< x 0) (- x) x))

(define (max-array-value nums)
  (let* ((n (length nums))
         (total-value (for/sum ((i (in-range 1 n)))
                        (abs (- (list-ref nums i) (list-ref nums (- i 1))))))
         (max-change 0))
    (for/list ((i (in-range (- n 1))))
      (set! max-change (max max-change
                           (- (abs (- (list-ref nums (+ i 1)) (list-ref nums i)))
                              (abs (- (list-ref nums i) (list-ref nums (+ i 1))))
                              (+ (abs (- (list-ref nums 0) (list-ref nums (+ i 1))))
                                 (abs (- (list-ref nums (+ i 1)) (list-ref nums 0)))
                                 (abs (- (list-ref nums i) (list-ref nums (- n 1))))
                                 (abs (- (list-ref nums (- n 1)) (list-ref nums i)))))))
    (for/list ((i (in-range (- n 2))))
      (set! max-change (max max-change
                           (- (abs (- (list-ref nums (+ i 2)) (list-ref nums (+ i 1))))
                              (abs (- (list-ref nums (+ i 1)) (list-ref nums (+ i 2))))
                              (+ (abs (- (list-ref nums (+ i 0)) (list-ref nums (+ i 2))))
                                 (abs (- (list-ref nums (+ i 2)) (list-ref nums (+ i 0)))))))))

    (+ total-value max-change)))