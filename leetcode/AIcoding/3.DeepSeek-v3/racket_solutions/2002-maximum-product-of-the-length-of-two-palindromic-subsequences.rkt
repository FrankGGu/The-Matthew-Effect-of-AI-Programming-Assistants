(define (max-product s)
  (define n (string-length s))
  (define max-p 0)

  (define (is-palindrome? str)
    (let loop ((i 0) (j (- (string-length str) 1)))
      (cond
        [(>= i j) #t]
        [(not (char=? (string-ref str i) (string-ref str j))) #f]
        [else (loop (+ i 1) (- j 1))])))

  (for* ([mask1 (in-range 1 (arithmetic-shift 1 n))]
         [mask2 (in-range 1 (arithmetic-shift 1 n))])
    (when (zero? (bitwise-and mask1 mask2))
      (define s1 "")
      (define s2 "")
      (for ([i (in-range n)])
        (when (bitwise-bit-set? mask1 i)
          (set! s1 (string-append s1 (string (string-ref s i))))
        (when (bitwise-bit-set? mask2 i)
          (set! s2 (string-append s2 (string (string-ref s i))))))
      (when (and (is-palindrome? s1) (is-palindrome? s2))
        (set! max-p (max max-p (* (string-length s1) (string-length s2)))))))

  max-p)