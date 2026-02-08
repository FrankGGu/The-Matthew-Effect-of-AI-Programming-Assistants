#lang racket

(define (max-vowels s k)
  (define (vowel? char)
    (or (char=? char #\a)
        (char=? char #\e)
        (char=? char #\i)
        (char=? char #\o)
        (char=? char #\u)))

  (define s-len (string-length s))

  (if (zero? s-len)
      0
      (let ([current-vowels 0]
            [max-vowels-count 0])

        (for ([i (in-range (min k s-len))])
          (when (vowel? (string-ref s i))
            (set! current-vowels (+ current-vowels 1))))

        (set! max-vowels-count current-vowels)

        (for ([i (in-range k s-len)])
          (when (vowel? (string-ref s (- i k)))
            (set! current-vowels (- current-vowels 1)))

          (when (vowel? (string-ref s i))
            (set! current-vowels (+ current-vowels 1)))

          (set! max-vowels-count (max max-vowels-count current-vowels)))

        max-vowels-count)))