#lang racket

(define (closest-prime-numbers left right)
  ;; Sieve of Eratosthenes
  (define sieve-limit (+ right 1))
  (define is-prime (make-vector sieve-limit #t))

  (vector-set! is-prime 0 #f)
  (vector-set! is-prime 1 #f)

  (for ([p (in-range 2 (add1 (floor (sqrt right))))])
    (when (vector-ref is-prime p)
      (for ([multiple (in-range (* p p) sieve-limit p)])
        (vector-set! is-prime multiple #f))))

  ;; Collect primes in the given range
  (define primes-in-range '())
  (for ([i (in-range left sieve-limit)])
    (when (vector-ref is-prime i)
      (set! primes-in-range (cons i primes-in-range))))
  (set! primes-in-range (reverse primes-in-range))

  ;; Find the closest pair
  (if (< (length primes-in-range) 2)
      '(-1 -1)
      (let loop ((current-primes (cdr primes-in-range))
                 (prev-prime (car primes-in-range))
                 (min-diff +inf.0)
                 (result-p1 -1)
                 (result-p2 -1))
        (if (empty? current-primes)
            (list result-p1 result-p2)
            (let* ((current-prime (car current-primes))
                   (diff (- current-prime prev-prime)))
              (if (< diff min-diff)
                  (loop (cdr current-primes)
                        current-prime
                        diff
                        prev-prime
                        current-prime)
                  (loop (cdr current-primes)
                        current-prime
                        min-diff
                        result-p1
                        result-p2)))))))