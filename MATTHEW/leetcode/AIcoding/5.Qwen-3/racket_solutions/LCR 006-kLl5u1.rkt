(define (two-sum nums target)
  (let loop ((left 0) (right (- (length nums) 1)))
    (cond ((= left right) #f)
          ((= (+ (list-ref nums left) (list-ref nums right)) target)
           (list (+ left 1) (+ right 1)))
          ((< (+ (list-ref nums left) (list-ref nums right)) target)
           (loop (+ left 1) right))
          (else
           (loop left (- right 1))))))