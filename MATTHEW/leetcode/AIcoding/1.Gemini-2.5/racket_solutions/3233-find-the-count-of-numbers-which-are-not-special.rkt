#lang racket

(define (non-special-numbers l r)
  ; Calculate the maximum possible prime 'p' such that p*p could be <= r.
  ; We only need to find primes up to this limit for the sieve.
  (define max-prime-candidate (floor (sqrt r)))

  ; Initialize a boolean vector for the Sieve of Eratosthenes.
  ; is-prime[i] will be #t if i is prime, #f otherwise.
  ; The vector size is max-prime-candidate + 1 to include max-prime-candidate itself.
  (define is-prime (make-vector (+ max-prime-candidate 1) #t))

  ; 0 and 1 are not prime.
  (when (>= (vector-length is-prime) 1) (vector-set! is-prime 0 #f))
  (when (>= (vector-length is-prime) 2) (vector-set! is-prime 1 #f))

  ; Sieve of Eratosthenes
  ; Iterate from 2 up to max-prime-candidate.
  (for ([p (in-range 2 (add1 max-prime-candidate))])
    (when (vector-ref is-prime p)
      ; If p is prime, mark all its multiples (starting from p*p) as not prime.
      ; Multiples smaller than p*p would have already been marked by smaller primes.
      (for ([m (in-range (* p p) (add1 max-prime-candidate) p)])
        (vector-set! is-prime m #f))))

  ; Count the number of "special" numbers within the range [l, r].
  ; A number x is special if it is the square of a prime number (x = p*p).
  (define special-count 0)
  (for ([p (in-range 2 (add1 max-prime-candidate))])
    (when (vector-ref is-prime p)
      ; Calculate the square of the current prime.
      (define square (* p p))
      ; Check if this square falls within the given range [l, r].
      (when (and (>= square l) (<= square r))
        ; If it does, increment the special_count.
        (set! special-count (add1 special-count)))))

  ; The total number of integers in the range [l, r] is (r - l + 1).
  ; The result is the total numbers minus the count of special numbers.
  (- (add1 (- r l)) special-count))