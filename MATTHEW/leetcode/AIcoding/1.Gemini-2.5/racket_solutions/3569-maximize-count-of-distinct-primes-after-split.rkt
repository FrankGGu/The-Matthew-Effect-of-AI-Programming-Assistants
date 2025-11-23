(define (get-distinct-prime-factors num)
  (define factors (make-hash))
  (define current-num num)
  (define d 2)

  (while (and (<= (* d d) current-num) (> current-num 1))
    (when (= (remainder current-num d) 0)
      (hash-set! factors d #t)
      (set! current-num (/ current-num d))
      (while (= (remainder current-num d) 0)
        (set! current-num (/ current-num d))))
    (set! d (add1 d)))

  (when (> current-num 1)
    (hash-set! factors current-num #t))

  (hash-keys factors))

(define (maximize-count-of-distinct-primes-after-split n)
  (define max-distinct-primes 0)

  (for ([a (in-range 1 n)])
    (define b (- n a))

    (define factors-a (get-distinct-prime-factors a))
    (define factors-b (get-distinct-prime-factors b))

    (define combined-factors (make-hash))
    (for ([p factors-a]) (hash-set! combined-factors p #t))
    (for ([p factors-b]) (hash-set! combined-factors p #t))

    (set! max-distinct-primes (max max-distinct-primes (hash-count combined-factors))))

  max-distinct-primes)