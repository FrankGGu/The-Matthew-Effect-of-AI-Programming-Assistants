(define (find-the-longest-substring s)
  (define (vowel-mask c)
    (cond [(char=? c #\a) 1]
          [(char=? c #\e) 2]
          [(char=? c #\i) 4]
          [(char=? c #\o) 8]
          [(char=? c #\u) 16]
          [else 0]))

  (define (longest-substring s)
    (define len (string-length s))
    (define mask 0)
    (define indices (make-vector 32 -1))
    (vector-set! indices 0 0)
    (define max-length 0)

    (for ([i (in-range len)])
      (set! mask (bit-xor mask (vowel-mask (string-ref s i))))
      (define index (vector-ref indices mask))
      (if (not (= index -1))
          (set! max-length (max max-length (- i index)))
          (vector-set! indices mask i)))

    max-length))

  (longest-substring s))