#lang racket

(define (contains? s c)
  (member c (string->list s)))

(define (count-substrings s k)
  (define vowels #(#\a #\e #\i #\o #\u))
  (define len (string-length s))
  (define count (make-hash))
  (define (get-vowel-count)
    (for/sum ([v vowels])
      (if (hash-has-key? count v) (hash-ref count v) 0)))

  (define (is-vowel? c)
    (contains? "aeiou" c))

  (define (is-consonant? c)
    (not (is-vowel? c)))

  (define res 0)
  (define consonant-count 0)
  (define vowel-count 0)
  (define freq (make-hash))

  (for ([i (in-range len)])
    (when (is-consonant? (string-ref s i))
      (set! consonant-count (+ consonant-count 1))
      (when (>= consonant-count k)
        (let loop ([j 0])
          (when (< j i)
            (when (is-consonant? (string-ref s j))
              (set! consonant-count (- consonant-count 1))
              (when (>= consonant-count k)
                (let ([current (substring s j i)])
                  (define current-vowel-count (for/sum ([c (string->list current)])
                                                (if (is-vowel? c) 1 0)))
                  (when (= current-vowel-count 5)
                    (set! res (+ res 1)))))
              (loop (+ j 1)))))))

    (when (is-vowel? (string-ref s i))
      (hash-set! freq (string-ref s i) (+ (hash-ref freq (string-ref s i) 0) 1))
      (set! vowel-count (+ vowel-count 1))))

  res)