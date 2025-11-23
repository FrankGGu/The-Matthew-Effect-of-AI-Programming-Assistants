(define (number-of-beautiful-partitions s k min-length)
  (define n (string-length s))
  (define MOD 1000000007)

  (define (is-vowel char)
    (or (char=? char #\a)
        (char=? char #\e)
        (char=? char #\i)
        (char=? char #\o)
        (char=? char #\u)))

  (define (is-consonant char)
    (and (char-alphabetic? char)
         (not (is-vowel char))))

  (define dp (make-vector (+ n 1)))
  (for ([idx (in-range (+ n 1))])
    (vector-set! dp idx (make-vector (+ k 1) 0)))

  (vector-set! (vector-ref dp 0) 0 1)

  (for ([j (in-range 1 (+ k 1))])
    (for ([i (in-range 1 (+ n 1))])
      (for ([p (in-range 0 (+ (- i min-length) 1))])
        (let ([first-char (string-ref s p)]
              [last-char (string-ref s (- i 1))])
          (when (and (is-vowel first-char)
                     (is-consonant last-char))
            (let ([prev-ways (vector-ref (vector-ref dp p) (- j 1))])
              (vector-set! (vector-ref dp i) j
                           (modulo (+ (vector-ref (vector-ref dp i) j) prev-ways) MOD))))))))

  (vector-ref (vector-ref dp n) k))