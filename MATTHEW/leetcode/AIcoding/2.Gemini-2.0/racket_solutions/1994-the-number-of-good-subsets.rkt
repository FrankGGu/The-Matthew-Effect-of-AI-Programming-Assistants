(define (number-of-good-subsets nums)
  (define primes '(2 3 5 7 11 13 17 19 23 29))
  (define masks (make-vector 31 0))
  (define counts (make-hash))

  (for ([i nums])
    (hash-update! counts i (λ (v) (+ v 1)) 0))

  (for ([i (in-range 2 31)])
    (let loop ([p primes] [mask 0] [n i])
      (cond
        [(empty? p)
         (vector-set! masks i mask)]
        [(zero? (modulo n (car p)))
         (if (zero? (modulo n (expt (car p) 2)))
             (vector-set! masks i -1)
             (vector-set! masks i (bitwise-ior mask (expt 2 (index-of primes (car p)))))
             )]
        [else
         (loop (cdr p) mask n)])))

  (define dp (make-vector 1024 0))
  (vector-set! dp 0 1)

  (for ([i (in-range 2 31)])
    (let ([mask (vector-ref masks i)])
      (when (and (>= mask 0) (hash-has-key? counts i))
        (let ([count (hash-ref counts i)])
          (for ([j (in-range 1024)])
            (when (not (zero? (vector-ref dp j)))
              (when (zero? (bitwise-and j mask))
                (vector-set! dp mask (modulo (+ (vector-ref dp mask) (expt 2 count) ) 1000000007))
                (vector-set! dp (bitwise-ior j mask) (modulo (+ (vector-ref dp (bitwise-ior j mask)) (* (vector-ref dp j) count)) 1000000007)))))))))

  (define ans 0)
  (for ([i (in-range 1024)])
    (set! ans (modulo (+ ans (vector-ref dp i)) 1000000007)))

  (set! ans (modulo (- ans 1) 1000000007))

  (if (hash-has-key? counts 1)
      (modulo (* ans (expt 2 (hash-ref counts 1))) 1000000007)
      ans))