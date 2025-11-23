(define (number-of-ways s)
  (define n (string-length s))
  (define MOD 1000000007)
  (define dp (make-vector (add1 n) 0))
  (vector-set! dp 0 1)

  (define (valid? i len)
    (and
     (not (= (string-ref s i) #\0))
     (<= (+ i len) n)
     (or
      (< len (- n i))
      (let loop ((j 0))
        (cond
          ((= j len) #t)
          ((> (string-ref s i) (string-ref s (- i len) j)) #t)
          ((< (string-ref s i) (string-ref s (- i len) j)) #f)
          (else (loop (add1 j))))))))

  (for ((i (in-range 1 (add1 n))))
    (for ((len (in-range 1 (add1 i))))
      (when (valid? (- i len) len)
        (vector-set! dp i (modulo (+ (vector-ref dp i) (vector-ref dp (- i len))) MOD)))))

  (vector-ref dp n))