#lang racket

(define (maximum-score nums k)
  (define n (length nums))
  (define (next-greater-element comp)
    (define stack '())
    (define res (make-vector n n))
    (for ([i (in-range n)])
      (while (and (not (null? stack)) (comp (list-ref nums i) (list-ref nums (car stack))))
        (vector-set! res (car stack) i)
        (set! stack (cdr stack)))
      (set! stack (cons i stack)))
    res)

  (define next-greater (next-greater-element >))
  (define next-smaller (next-greater-element <))

  (define prev-greater (next-greater-element (lambda (x y) (> y x))))
  (define prev-smaller (next-greater-element (lambda (x y) (< y x))))

  (define primes (sieve (apply max nums)))

  (define (prime-score x)
    (define cnt 0)
    (define temp x)
    (for ([p (in-list primes)] #:break (<= (* p p) temp))
      (when (zero? (modulo temp p))
        (set! cnt (add1 cnt))
        (while (zero? (modulo temp p))
          (set! temp (quotient temp p)))))
    (if (> temp 1) (add1 cnt) cnt))

  (define nums-with-score
    (for/list ([num (in-list nums)])
      (cons num (prime-score num))))

  (define (get-k-max)
    (define max-heap (make-heap (lambda (a b) (> (cdr a) (cdr b))))))
    (for ([i (in-range n)])
      (define left (if (= (vector-ref prev-greater i) -1) 0 (add1 (vector-ref prev-greater i))))
      (define right (if (= (vector-ref next-greater i) n) (sub1 n) (sub1 (vector-ref next-greater i))))
      (define count (* (add1 (- i left)) (add1 (- right i))))
      (heap-add! max-heap (cons (car (list-ref nums-with-score i)) count)))

    (define result 1)
    (define modulo 1000000007)
    (for ([_ (in-range k)] #:break (heap-empty? max-heap))
      (define current (heap-remove! max-heap))
      (set! result (modulo (* result (expt (car current) (min k (cdr current)))) modulo))
      (set! k (max 0 (- k (cdr current)))))
    result)

  (get-k-max))

(define (sieve limit)
  (when (< limit 2) (return '()))
  (define sieve (make-vector (add1 limit) #t))
  (vector-set! sieve 0 #f)
  (vector-set! sieve 1 #f)
  (for ([i (in-range 2 (add1 (integer-sqrt limit)))])
    (when (vector-ref sieve i)
      (for ([j (in-range (* i i) (add1 limit) i)])
        (vector-set! sieve j #f))))
  (for/list ([i (in-range 2 (add1 limit))] #:when (vector-ref sieve i)) i))