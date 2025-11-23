(define (is-prime n)
  (if (< n 2) #f
      (let loop ((i 2))
        (cond ((> i (sqrt n)) #t)
              ((= (modulo n i) 0) #f)
              (else (loop (+ i 1)))))))

(define (next-prime n)
  (define (iter m)
    (if (is-prime m) m
        (iter (+ m 1))))
  (iter (+ n 1)))

(define (max-prime-diff arr)
  (define primes (map (lambda (x) (next-prime x)) arr))
  (define max-diff 0)
  (for ((i (in-range (length primes))))
    (for ((j (in-range (add1 i) (length primes))))
      (set! max-diff (max max-diff (- (list-ref primes j) (list-ref primes i))))))
  max-diff)

(max-prime-diff arr)