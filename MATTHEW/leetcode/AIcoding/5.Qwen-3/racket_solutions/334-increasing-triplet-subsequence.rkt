(define (increasing-triplet-subsequence nums)
  (let ((first #inf) (second #inf))
    (for-each
     (lambda (n)
       (cond ((<= n first) (set! first n))
             ((<= n second) (set! second n))))
     nums)
    (and (< first second) (< second #inf))))