(define (first-unique-char s)
  (define char-counts (make-hash))
  (define len (string-length s))

  (for ([i (in-range len)])
    (define c (string-ref s i))
    (hash-set! char-counts c (+ (hash-ref char-counts c 0) 1)))

  (let loop ([i 0])
    (cond
      [(= i len) -1]
      [(= (hash-ref char-counts (string-ref s i)) 1) i]
      [else (loop (+ i 1))])))