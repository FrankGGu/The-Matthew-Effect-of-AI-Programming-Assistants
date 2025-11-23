(define (count-squares n k)
  (if (zero? k)
      1
      (let loop ([i 1] [acc 0])
        (if (> i n)
            acc
            (loop (+ i 1) (+ acc (expt (- n i 1) 2)))))))

(define (solve n m k)
  (let ([total-squares (count-squares n k)])
    (if (>= m total-squares)
        #t
        #f)))

(define (make-a-square-with-the-same-color n m k)
  (solve n m k))