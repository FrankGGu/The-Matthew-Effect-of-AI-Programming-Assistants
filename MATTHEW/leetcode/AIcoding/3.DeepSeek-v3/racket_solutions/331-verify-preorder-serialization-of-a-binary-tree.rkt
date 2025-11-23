(define (isValidSerialization preorder)
  (let loop ([nodes (string-split preorder ",")] [slots 1])
    (cond
      [(null? nodes) (= slots 0)]
      [(= slots 0) #f]
      [else
       (let ([node (car nodes)])
         (if (string=? node "#")
             (loop (cdr nodes) (sub1 slots))
             (loop (cdr nodes) (+ slots 1))))]))