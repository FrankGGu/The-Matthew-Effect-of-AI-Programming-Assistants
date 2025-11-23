#lang racket

(require math/number-theory)

(define/contract (gcd-sort nums)
  (-> (listof exact-integer?) boolean?)
  (define n (length nums))
  (define parent (make-vector (* n 2) -1))

  (define (find u)
    (if (= (vector-ref parent u) -1)
        u
        (let ([p (find (vector-ref parent u))])
          (vector-set! parent u p)
          p)))

  (define (union u v)
    (let ([pu (find u)]
          [pv (find v)])
      (unless (= pu pv)
        (vector-set! parent pu pv))))

  (define primes (filter prime? (range 2 100001)))

  (define prime-idx (make-hash))
  (for ([p primes] [i (in-naturals)])
    (hash-set! prime-idx p (+ i n)))

  (for ([(num idx) (in-indexed nums)])

  (for ([(num idx) (in-indexed nums)])
    (let loop ([x num])
      (when (> x 1)
        (let ([p (find-prime-factor x primes)])
          (union idx (hash-ref prime-idx p))
          (loop (/ x p)))))))

  (define sorted-nums (sort nums <))

  (for ([i (in-range n)])
    (unless (= (find i) (find (index-of nums (list-ref sorted-nums i))))
      (return #f)))

  #t)

(define (find-prime-factor x primes)
  (for/or ([p primes])
    (and (zero? (modulo x p)) p)))

(define (return v) v)