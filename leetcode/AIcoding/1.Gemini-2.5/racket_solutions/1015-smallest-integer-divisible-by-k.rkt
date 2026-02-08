(define (smallest-repunit-divisible-by-k k)
  (if (or (= (remainder k 2) 0) (= (remainder k 5) 0))
      -1
      (let loop ((current-remainder 0)
                 (len 0))
        (let ((next-remainder (remainder (+ (* current-remainder 10) 1) k)))
          (cond
            ((= next-remainder 0) (+ len 1))
            ((= len k) -1)
            (else (loop next-remainder (+ len 1))))))))