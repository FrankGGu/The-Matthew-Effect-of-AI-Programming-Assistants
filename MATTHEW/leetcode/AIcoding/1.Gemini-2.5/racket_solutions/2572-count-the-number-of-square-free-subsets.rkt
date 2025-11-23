#lang racket

(define (square-free-subsets nums)
  (define MOD 1000000007)
  (define primes (list 2 3 5 7 11 13 17 19 23 29))
  (define num-primes (length primes))
  (define max-mask (arithmetic-shift 1 num-primes))

  (define (is-square-free? n)
    (and
     (not (zero? (modulo n 4)))
     (not (zero? (modulo n 9)))
     (not (zero? (modulo n 25)))))

  (define (get-prime-mask n)
    (let loop ((num n) (idx 0) (mask 0))
      (if (= idx num-primes)
          mask
          (let ((p (list-ref primes idx)))
            (if (zero? (modulo num p))
                (loop (/ num p) (+ idx 1) (bitwise-ior mask (arithmetic-shift 1 idx)))
                (loop num (+ idx 1) mask))))))

  (define dp (make-vector max-mask 0))
  (vector-set! dp 0 1)

  (for-each (lambda (num)
              (when (is-square-free? num)
                (let ((p-mask (get-prime-mask num)))
                  (for i (in-range (- max-mask 1) -1 -1)
                    (when (not (zero? (vector-ref dp i)))
                      (when (zero? (bitwise-and i p-mask))
                        (vector-set! dp (bitwise-ior i p-mask)
                                     (modulo (+ (vector-ref dp (bitwise-ior i p-mask))
                                                (vector-ref dp i))
                                             MOD))))))))
            nums)

  (let ((total-subsets 0))
    (for i (in-range max-mask)
      (set! total-subsets (modulo (+ total-subsets (vector-ref dp i)) MOD)))
    (modulo (- total-subsets 1) MOD)))