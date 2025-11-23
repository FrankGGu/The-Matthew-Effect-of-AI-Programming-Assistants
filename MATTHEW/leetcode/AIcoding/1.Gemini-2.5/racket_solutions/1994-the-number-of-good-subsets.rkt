#lang racket

(define MOD 1000000007)

(define (power base exp mod)
  (let loop ([b base] [e exp] [res 1])
    (cond
      ((zero? e) res)
      (else
       (let ([new-res (if (odd? e) (modulo (* res b) mod) res)])
         (loop (modulo (* b b) mod) (quotient e 2) new-res))))))

(define primes (list 2 3 5 7 11 13 17 19 23 29))

(define prime-to-idx
  (let ([ht (make-hash)])
    (for ([p (in-list primes)] [i (in-range (length primes))])
      (hash-set! ht p i))
    ht))

(define (is-square-free? n primes)
  (let loop ([ps primes])
    (cond
      ((null? ps) #t)
      (else
       (let ([p (car ps)])
         (cond
           ((> (* p p) n) #t)
           ((zero? (modulo n (* p p))) #f)
           (else (loop (cdr ps)))))))))

(define (get-prime-mask n primes prime-to-idx)
  (let loop ([ps primes] [mask 0])
    (cond
      ((null? ps) mask)
      (else
       (let ([p (car ps)])
         (if (zero? (modulo n p))
             (loop (cdr ps) (bitwise-ior mask (arithmetic-shift 1 (hash-ref prime-to-idx p))))
             (loop (cdr ps) mask)))))))

(define (number-of-good-subsets count)
  (let* ([num-primes (length primes)]
         [dp-size (arithmetic-shift 1 num-primes)]
         [dp (make-vector dp-size 0)]
         [num-ones (vector-ref count 0)])

    (vector-set! dp 0 1)

    (for ([i (in-range 2 31)])
      (let ([current-num-count (vector-ref count (- i 1))])
        (when (> current-num-count 0)
          (when (is-square-free? i primes)
            (let ([p-mask-i (get-prime-mask i primes prime-to-idx)])
              (for ([mask (in-range (- dp-size 1) -1 -1)])
                (when (> (vector-ref dp mask) 0)
                  (when (zero? (bitwise-and mask p-mask-i))
                    (let ([new-mask (bitwise-ior mask p-mask-i)])
                      (vector-set! dp new-mask
                                   (modulo (+ (vector-ref dp new-mask)
                                              (modulo (* (vector-ref dp mask) current-num-count) MOD))
                                           MOD))))))))))

    (let ([total-good-subsets-without-ones
           (let loop ([mask 1] [sum 0])
             (if (< mask dp-size)
                 (loop (+ mask 1) (modulo (+ sum (vector-ref dp mask)) MOD))
                 sum))])

      (if (> num-ones 0)
          (modulo (* total-good-subsets-without-ones (power 2 num-ones MOD)) MOD)
          total-good-subsets-without-ones))))