(define (count-special-integers n)
  (define (num-length x)
    (if (< x 10) 1 (+ 1 (num-length (quotient x 10)))))

  (define (permutations a b)
    (if (zero? b) 1 (* a (permutations (- a 1) (- b 1)))))

  (define (count-numbers-with-unique-digits len)
    (if (= len 1) 10 (* 9 (permutations 9 (- len 1)))))

  (define (count-less-than x digits len)
    (if (zero? len)
        1
        (let* ([first-digit (first digits)]
               [remaining-digits (rest digits)]
               [remaining-len (- len 1)]
               [start (if (= len (num-length x)) 1 0)]
               [total 0])
          (for ([d (in-range start first-digit)])
            (when (not (bitwise-bit-set? used d))
              (set! total (+ total (permutations (- 10 (- (num-length x) len)) remaining-len)))))
          (when (not (bitwise-bit-set? used first-digit))
            (set! used (bitwise-ior used (arithmetic-shift 1 first-digit)))
            (set! total (+ total (count-less-than x remaining-digits remaining-len))))
          total)))

  (if (< n 10)
      n
      (let* ([len (num-length n)]
             [total 0]
             [used 0])
        (for ([i (in-range 1 len)])
          (set! total (+ total (count-numbers-with-unique-digits i)))
        (set! total (+ total (count-less-than n (digits n) len)))
        total)))

(define (digits x)
  (if (< x 10)
      (list x)
      (append (digits (quotient x 10)) (list (remainder x 10))))