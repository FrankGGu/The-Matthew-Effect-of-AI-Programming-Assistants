#lang racket

(define (beautiful-substrings s k)
  (define n (string-length s))
  (define vowels (set #\a #\e #\i #\o #\u #\A #\E #\I #\O #\U))
  (define prefix (make-vector (+ n 1) 0))
  (define prefix-xor (make-vector (+ n 1) 0))

  (for ([i (in-range 1 (+ n 1))])
    (define ch (string-ref s (- i 1)))
    (define vowel? (set-member? vowels ch))
    (vector-set! prefix i (+ (vector-ref prefix (- i 1)) (if vowel? 1 0)))
    (vector-set! prefix-xor i (bitwise-xor (vector-ref prefix-xor (- i 1)) (if vowel? i 0))))

  (define count 0)
  (define freq (make-hash))

  (for ([i (in-range 0 (+ n 1))])
    (define key (cons (vector-ref prefix i) (vector-ref prefix-xor i)))
    (define val (hash-ref freq key 0))
    (set! count (+ count val))
    (hash-set! freq key (+ val 1)))

  count)