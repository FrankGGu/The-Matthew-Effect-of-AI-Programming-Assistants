#lang racket

(define MAX_SIEVE_LIMIT 2000000) ; A common limit for sieves in competitive programming
(define primes-sieve (make-vector (+ MAX_SIEVE_LIMIT 1) #t))
(define primes-list '())

(define (init-sieve)
  (vector-set! primes-sieve 0 #f)
  (vector-set! primes-sieve 1 #f)
  (for ([p (in-range 2 (add1 (sqrt MAX_SIEVE_LIMIT)))])
    (when (vector-ref primes-sieve p)
      (for ([i (in-range (* p p) (add1 MAX_SIEVE_LIMIT) p)])
        (vector-set! primes-sieve i #f))))
  (set! primes-list
        (for/list ([p (in-range 2 (add1 MAX_SIEVE_LIMIT))]
                   #:when (vector-ref primes-sieve p))
          p)))

(init-sieve)

(define (is-prime? n)
  (cond
    ((< n 2) #f)
    ((= n 2) #t)
    ((even? n) #f)
    ((<= n MAX_SIEVE_LIMIT) (vector-ref primes-sieve n))
    (else ; For numbers larger than MAX_SIEVE_LIMIT, use trial division
     (let loop ([d 3])
       (cond
         ((> (* d d) n) #t)
         ((zero? (remainder n d)) #f)
         (else (loop (+ d 2))))))))

(define (find-largest-prime-less-than limit)
  (cond
    ((< limit 2) #f)
    ((<= limit MAX_SIEVE_LIMIT)
     ;; Binary search on primes-list to find the largest prime <= limit-1
     (let ([target (- limit 1)])
       (let loop ([low 0] [high (- (length primes-list) 1)] [ans-prime #f])
         (if (> low high)
             ans-prime
             (let ([mid (quotient (+ low high) 2)])
               (let ([p (list-ref primes-list mid)])
                 (if (<= p target)
                     (loop (+ mid 1) high p) ; p is a candidate, try larger in right half
                     (loop low (- mid 1) ans-prime))))))))
    (else ; limit > MAX_SIEVE_LIMIT
     ;; Iterate downwards from limit-1, use is-prime?
     (let loop ([k (- limit 1)])
       (cond
         ((< k 2) #f)
         ((is-prime? k) k)
         (else (loop (- k 1))))))))

(define (prime-subtraction-operation nums)
  (let ([n (vector-length nums)])
    (let loop ([i 0] [prev 0])
      (if (= i n)
          #t
          (let* ([current-num (vector-ref nums i)]
                 [limit (- current-num prev)]
                 [p (find-largest-prime-less-than limit)])
            (if p
                (loop (+ i 1) (- current-num p))
                (if (<= current-num prev)
                    #f
                    (loop (+ i 1) current-num))))))))

(define (can-make-strictly-increasing nums)
  (prime-subtraction-operation (list->vector nums)))