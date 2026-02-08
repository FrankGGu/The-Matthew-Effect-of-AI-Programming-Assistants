#lang racket

(define (mostFrequentPrime(nums))
  (define (is-prime n)
    (and (> n 1) (not (ormap (lambda (i) (= 0 (remainder n i))) (range 2 (add1 (floor (sqrt n))))))))

  (define prime-counts (make-hash))

  (for ([num nums])
    (when (is-prime num)
      (hash-set! prime-counts num (+ 1 (hash-ref prime-counts num 0)))))

  (define most-frequent (for/sum ([key (hash-keys prime-counts)])
                           (values key (hash-ref prime-counts key 0))))

  (if (null? most-frequent)
      -1
      (define-values (max-prime max-count) (apply max (map (λ (k) (values k (hash-ref prime-counts k))) (hash-keys prime-counts))))
      max-prime))

(define (mostFrequentPrime nums)
  (mostFrequentPrime nums))