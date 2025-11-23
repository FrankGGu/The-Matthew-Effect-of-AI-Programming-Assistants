(define (count-substrings s k)
  (define (vowel? char)
    (or (char=? char #\a)
        (char=? char #\e)
        (char=? char #\i)
        (char=? char #\o)
        (char=? char #\u)))

  (define (consonant? char)
    (and (char-alphabetic? char)
         (char-lower-case? char)
         (not (vowel? char))))

  (define n (string-length s))
  (define total-count 0)

  (for ([i (in-range n)])
    (define current-vowel-counts (make-hash))
    (hash-set! current-vowel-counts #\a 0)
    (hash-set! current-vowel-counts #\e 0)
    (hash-set! current-vowel-counts #\i 0)
    (hash-set! current-vowel-counts #\o 0)
    (hash-set! current-vowel-counts #\u 0)

    (define current-consonant-count 0)

    (for ([j (in-range i n)])
      (define char (string-ref s j))
      (cond
        ((vowel? char)
         (hash-update! current-vowel-counts char add1))
        ((consonant? char)
         (set! current-consonant-count (add1 current-consonant-count))))

      (when (and (>= (hash-ref current-vowel-counts #\a) 1)
                 (>= (hash-ref current-vowel-counts #\e) 1)
                 (>= (hash-ref current-vowel-counts #\i) 1)
                 (>= (hash-ref current-vowel-counts #\o) 1)
                 (>= (hash-ref current-vowel-counts #\u) 1)
                 (= current-consonant-count k))
        (set! total-count (add1 total-count)))))

  total-count)