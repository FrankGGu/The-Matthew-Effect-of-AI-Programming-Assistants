(define (can-i-win maxChoosableInteger desiredTotal)
  (cond
    ((zero? desiredTotal) #t)

    (else
     (let* ((total-sum (/ (* maxChoosableInteger (+ maxChoosableInteger 1)) 2)))
       (cond
         ((< total-sum desiredTotal) #f)
         (else
          (define memo (make-hash))

          (define (can-win-helper mask current-sum)
            (cond
              ((>= current-sum desiredTotal) #f)
              ((hash-has-key? memo mask) (hash-ref memo mask))
              (else
               (let loop ((i 1))
                 (cond
                   ((> i maxChoosableInteger)
                    (hash-set! memo mask #f)
                    #f)
                   (else
                    (let ((bit (arithmetic-shift 1 (- i 1))))
                      (if (zero? (bitwise-and mask bit))
                          (let ((new-mask (bitwise-ior mask bit))
                                (new-sum (+ current-sum i)))
                            (if (>= new-sum desiredTotal)
                                (begin
                                  (hash-set! memo mask #t)
                                  #t)
                                (if (not (can-win-helper new-mask new-sum))
                                    (begin
                                      (hash-set! memo mask #t)
                                      #t)
                                    (loop (+ i 1)))))
                          (loop (+ i 1))))))))))
          (can-win-helper 0 0))))))