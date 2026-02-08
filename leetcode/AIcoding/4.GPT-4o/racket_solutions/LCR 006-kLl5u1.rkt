(define (twoSum numbers target)
  (let loop ((left 0) (right (sub1 (length numbers))))
    (cond
      ((= (+ (list-ref numbers left) (list-ref numbers right)) target) 
       (list (+ left 1) (+ right 1)))
      ((< (+ (list-ref numbers left) (list-ref numbers right)) target) 
       (loop (add1 left) right))
      (else 
       (loop left (sub1 right))))))