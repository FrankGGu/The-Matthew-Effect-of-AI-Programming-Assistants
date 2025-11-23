(define (rand7)
  (random 1 8)) ; Simulating rand7() which returns a random integer from 1 to 7

(define (rand10)
  (let loop ()
    (let* ((num (+ (* (- (rand7) 1) 7) (rand7))) ; Generate a number from 1 to 49
           (adjusted-num (modulo num 10))) ; Adjust to get values from 0 to 9
      (if (< adjusted-num 40)
          (+ 1 adjusted-num) ; Map to 1 to 10
          (loop))))) ; Retry if out of bounds