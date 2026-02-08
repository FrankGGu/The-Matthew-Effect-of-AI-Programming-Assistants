(define (count-primes n)
  (if (<= n 2)
      0
      (let ((sieve (make-vector n #t)))
        (vector-set! sieve 0 #f)
        (vector-set! sieve 1 #f)
        (let loop ((i 2) (count 0))
          (if (>= i n)
              count
              (if (vector-ref sieve i)
                  (begin
                    (let mark ((j (* i i)))
                      (when (< j n)
                        (vector-set! sieve j #f)
                        (mark (+ j i))))
                    (loop (+ i 1) (+ count 1)))
                  (loop (+ i 1) count)))))))