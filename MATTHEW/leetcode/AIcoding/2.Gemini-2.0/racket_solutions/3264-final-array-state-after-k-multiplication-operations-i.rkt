(define (final-array-state nums k)
  (cond ((zero? k) nums)
        (else
         (let loop ((nums nums) (k k))
           (if (zero? k)
               nums
               (let ((new-nums (make-vector (length nums))))
                 (for ((i (in-range (length nums))))
                   (vector-set! new-nums i (if (even? (vector-ref nums i))
                                                 (vector-ref nums i)
                                                 (- (vector-ref nums i)))))
                 (loop (list->vector (vector->list new-nums)) (- k 1))))))))