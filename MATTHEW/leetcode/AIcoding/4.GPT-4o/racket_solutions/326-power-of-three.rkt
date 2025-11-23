(define (isPowerOfThree n)
  (if (<= n 0)
      #f
      (let loop ([x n])
        (if (= x 1)
            #t
            (if (not (= (modulo x 3) 0))
                #f
                (loop (/ x 3)))))))