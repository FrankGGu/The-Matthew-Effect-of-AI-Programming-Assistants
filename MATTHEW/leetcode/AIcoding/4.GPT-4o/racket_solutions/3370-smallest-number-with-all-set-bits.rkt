(define (smallestNumberWithAllSetBits n)
  (if (zero? n)
      0
      (let loop ((x 0) (i 0))
        (if (= (bitwise-arithmetic-shift left n (- i)) 0)
            (bitwise-arithmetic-shift left (- (expt 2 i) 1) 0)
            (loop n (+ i 1))))))

(define (main)
  (display (smallestNumberWithAllSetBits 7)) ; Example input
  (newline))

(main)