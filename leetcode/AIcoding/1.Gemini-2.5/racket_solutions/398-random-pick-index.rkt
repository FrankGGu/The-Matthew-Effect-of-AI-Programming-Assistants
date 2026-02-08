#lang racket

(struct solution (nums)
  #:methods
  ((define (pick self target)
     (let* ((nums (solution-nums self))
            (n (vector-length nums)))
       (let loop ((i 0) (count 0) (result -1))
         (cond
           ((= i n) result)
           ((= (vector-ref nums i) target)
            (let ((new-count (+ count 1)))
              (if (= (random new-count) 0)
                  (loop (+ i 1) new-count i)
                  (loop (+ i 1) new-count result))))
           (else
            (loop (+ i 1) count result))))))))