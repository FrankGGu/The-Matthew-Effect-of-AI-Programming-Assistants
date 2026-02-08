(define (count-primes n)
  (if (<= n 2)
      0
      (let* ([is-prime (make-vector n #t)]
             (set! (vector-ref is-prime 0) #f)
             (set! (vector-ref is-prime 1) #f))
        (for ([i (in-range 2 (ceiling (sqrt n)))])
          (if (vector-ref is-prime i)
              (for ([j (in-range (* i i) n i)])
                (set! (vector-ref is-prime j) #f))))
        (length (filter identity (vector->list is-prime))))))