(define (integer-replacement n)
  (let loop ((current-n n) (steps 0))
    (cond
      ((= current-n 1) steps)
      ((even? current-n) (loop (/ current-n 2) (+ steps 1)))
      (else
       (cond
         ((= current-n 3) (loop (- current-n 1) (+ steps 1)))
         ((= (remainder current-n 4) 1) (loop (- current-n 1) (+ steps 1)))
         (else
          (loop (+ current-n 1) (+ steps 1))))))))