(define (is-prime n)
  (if (< n 2) #f
      (define (check-divisor d)
        (if (> (* d d) n) #t
            (if (= (modulo n d) 0) #f (check-divisor (+ d 1)))))
      (check-divisor 2)))

(define (prime-pairs target)
  (define (find-primes up-to)
    (filter is-prime (range 2 (+ up-to 1))))

  (define primes (find-primes target))

  (define (count-pairs)
    (define count 0)
    (for ([i (in-range (length primes))])
      (for ([j (in-range i (length primes))])
        (when (= (+ (list-ref primes i) (list-ref primes j)) target)
          (set! count (+ count 1)))))
    count)

  (count-pairs))

(define (num-prime-pairs target)
  (prime-pairs target))