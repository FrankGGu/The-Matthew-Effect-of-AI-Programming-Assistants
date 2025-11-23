(define (maximum-difference-circular-array nums)
  (let ((n (length nums)))
    (cond
      ((< n 2) 0) ; Handle empty or single-element array
      (else
       (let loop ((current-list nums)
                  (max-diff 0))
         (if (null? (cdr current-list))
             ; Reached the end of the linear pairs, now handle the circular pair
             (max max-diff (abs (- (car nums) (car current-list))))
             ; Calculate difference for the current adjacent pair
             (loop (cdr current-list)
                   (max max-diff (abs (- (car current-list) (car (cdr current-list))))))))))))