(define/contract (prime-sub-operation nums)
  (-> (listof exact-integer?) boolean?)
  (define (sieve n)
    (define primes (make-vector (+ n 1) #t))
    (vector-set! primes 0 #f)
    (vector-set! primes 1 #f)
    (for ([i (in-range 2 (add1 (integer-sqrt n)))])
      (when (vector-ref primes i)
        (for ([j (in-range (* i i) (add1 n) i)])
          (vector-set! primes j #f))))
    primes)

  (define max-num (apply max nums))
  (define primes-vec (sieve max-num))
  (define primes-list
    (for/list ([i (in-range 2 (add1 max-num))] #:when (vector-ref primes-vec i)) i))

  (define (find-largest-prime-less-than x)
    (let loop ([low 0] [high (sub1 (length primes-list))])
      (if (> low high)
          #f
          (let ([mid (quotient (+ low high) 2)])
            (cond
              [(= (list-ref primes-list mid) x) (if (> mid 0) (list-ref primes-list (sub1 mid)) #f)]
              [(< (list-ref primes-list mid) x) (if (or (= mid (sub1 (length primes-list))) (< (list-ref primes-list (add1 mid)) x))
                                                (list-ref primes-list mid)
                                                (loop (add1 mid) high))]
              [else (loop low (sub1 mid))])))))

  (let loop ([i 1] [prev (first nums)])
    (if (>= i (length nums))
        #t
        (let* ([current (list-ref nums i)]
               [diff (- current prev)]
               [p (if (<= diff 0) #f (find-largest-prime-less-than diff))])
          (if p
              (loop (add1 i) (- current p))
              (if (> current prev)
                  (loop (add1 i) current)
                  #f))))))