#lang racket

(define primes '(2 3 5 7 11 13 17 19 23 29))
(define mod 1000000007)

(define (number-of-good-subsets nums)
  (define freq (make-hash))
  (for ([num nums])
    (hash-update! freq num add1 0))
  (define dp (make-hash))
  (hash-set! dp 1 1)
  (for ([(mask cnt) (in-hash (get-masks freq))])
    (define new-dp (hash-copy dp))
    (for ([(curr-mask curr-cnt) (in-hash dp)])
      (when (zero? (bitwise-and curr-mask mask))
        (define new-mask (bitwise-ior curr-mask mask))
        (hash-update! new-dp new-mask (lambda (v) (modulo (+ v (* curr-cnt cnt)) mod) 0))
    (set! dp new-dp))
  (define total 0)
  (for ([(mask cnt) (in-hash dp)])
    (when (not (zero? mask))
      (set! total (modulo (+ total cnt) mod))))
  (define ones (hash-ref freq 1 0))
  (for ([i (in-range ones)])
    (set! total (modulo (* total 2) mod)))
  total)

(define (get-masks freq)
  (define masks (make-hash))
  (for ([(num cnt) (in-hash freq)])
    (when (and (not (= num 1)) (valid-num? num))
      (define mask (get-mask num))
      (hash-update! masks mask (lambda (v) (modulo (+ v cnt) mod)) 0))
  masks)

(define (valid-num? num)
  (let loop ([n num] [primes primes])
    (cond
      [(= n 1) #t]
      [(null? primes) #f]
      [(zero? (modulo n (car primes)))
       (if (zero? (modulo n (* (car primes) (car primes))))
           #f
           (loop (/ n (car primes)) (cdr primes)))]
      [else (loop n (cdr primes))])))

(define (get-mask num)
  (let loop ([n num] [primes primes] [mask 0] [i 0])
    (cond
      [(= n 1) mask]
      [(null? primes) 0]
      [(zero? (modulo n (car primes)))
       (loop (/ n (car primes)) (cdr primes)) (bitwise-ior mask (arithmetic-shift 1 i)) (+ i 1))]
      [else (loop n (cdr primes)) mask i]))))