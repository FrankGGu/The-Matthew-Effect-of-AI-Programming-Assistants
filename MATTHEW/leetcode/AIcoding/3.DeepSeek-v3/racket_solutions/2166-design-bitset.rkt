(struct bitset (size vec) #:mutable #:transparent)

(define (make-bitset size)
  (bitset size (make-vector (ceiling (/ size 32)) 0)))

(define (bitset-fix idx)
  (let ([i (quotient idx 32)]
        [j (remainder idx 32)])
  (values i j))

(define (bitset-set! bs idx)
  (let-values ([(i j) (bitset-fix idx)])
    (vector-set! (bitset-vec bs) i (bitwise-ior (vector-ref (bitset-vec bs) i) (arithmetic-shift 1 j)))))

(define (bitset-unset! bs idx)
  (let-values ([(i j) (bitset-fix idx)])
    (vector-set! (bitset-vec bs) i (bitwise-and (vector-ref (bitset-vec bs) i) (bitwise-not (arithmetic-shift 1 j))))))

(define (bitset-flip! bs)
  (let ([vec (bitset-vec bs)]
        [size (bitset-size bs)])
    (for ([i (in-range (vector-length vec))])
      (vector-set! vec i (bitwise-not (vector-ref vec i)))
    (let ([last-idx (quotient (sub1 size) 32)]
          [last-offset (remainder (sub1 size) 32)])
      (when (>= last-offset 0)
        (let ([mask (sub1 (arithmetic-shift 1 (add1 last-offset)))])
          (vector-set! vec last-idx (bitwise-and (vector-ref vec last-idx) mask)))))))

(define (bitset-all? bs)
  (let ([vec (bitset-vec bs)]
        [size (bitset-size bs)])
    (let ([full-words (quotient size 32)]
          [remaining-bits (remainder size 32)])
      (and (for/and ([i (in-range full-words)])
               (= (vector-ref vec i) #xFFFFFFFF))
           (or (zero? remaining-bits)
               (= (bitwise-and (vector-ref vec full-words) (sub1 (arithmetic-shift 1 remaining-bits))))))))

(define (bitset-one? bs)
  (let ([vec (bitset-vec bs)])
    (for/or ([i (in-range (vector-length vec))])
      (not (zero? (vector-ref vec i)))))

(define (bitset-count bs)
  (let ([vec (bitset-vec bs)])
    (for/sum ([i (in-range (vector-length vec))])
      (bitwise-bit-count (vector-ref vec i)))))

(define (bitset->string bs)
  (let ([vec (bitset-vec bs)]
        [size (bitset-size bs)])
    (let ([s (make-string size #\0)])
      (for ([i (in-range size)])
        (let-values ([(word bit) (bitset-fix i)])
          (when (bitwise-bit-set? (vector-ref vec word) bit)
            (string-set! s i #\1))))
      s)))