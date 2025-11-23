(define (can-reach s minJump maxJump)
  (define n (string-length s))
  (define (iter i farthest)
    (if (>= i n)
        #f
        (cond
          ((= (string-ref s i) #\0) 
           (if (>= i farthest) 
               #f 
               (let ((next-farthest (min n (+ i maxJump))))
                 (iter (+ i 1) (max farthest next-farthest)))))
          (else 
           (iter (+ i 1) farthest)))))
  (iter 0 0))

(define (can-reach-main s minJump maxJump)
  (if (string-ref s 0) #\0)
      (can-reach s minJump maxJump)
      #f)