(define (num-students-in-homework start-time end-time)
  (define (count-students i)
    (if (= i (length start-time))
        0
        (+ (if (<= (list-ref start-time i) (list-ref end-time i)) 1 0)
           (count-students (+ i 1)))))
  (count-students 0))