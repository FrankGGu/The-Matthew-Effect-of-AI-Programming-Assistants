#lang racket

(define (number-of-unique-good-subsequences binary)
  (define mod 1000000007)
  (define dp-ends-0 0) ; Number of unique subsequences starting with '1' and ending with '0'
  (define dp-ends-1 0) ; Number of unique subsequences starting with '1' and ending with '1'
  (define has-seen-one #f) ; Flag to ensure subsequences only start being counted after the first '1'

  (for ([char (string->list binary)])
    (cond
      [(char=? char #\0)
       ; If a '0' is encountered, and we have already seen a '1',
       ; we can form new subsequences ending in '0' by appending '0'
       ; to all existing subsequences that started with '1' and ended with '0' (dp-ends-0)
       ; or ended with '1' (dp-ends-1).
       (when has-seen-one
         (set! dp-ends-0 (modulo (+ dp-ends-0 dp-ends-1) mod)))]
      [(char=? char #\1)
       ; If a '1' is encountered:
       ; 1. Mark that we have seen a '1'.
       (set! has-seen-one #t)
       ; 2. Form new subsequences ending in '1' by appending '1' to:
       ;    - All existing subsequences that started with '1' and ended with '0' (dp-ends-0).
       ;    - All existing subsequences that started with '1' and ended with '1' (dp-ends-1).
       ;    - The single subsequence "1" itself (represented by the '+ 1').
       (set! dp-ends-1 (modulo (+ dp-ends-0 dp-ends-1 1) mod))]))

  ; The total number of unique good subsequences is the count of unique subsequences
  ; that started with '1' and ended with '1'.
  dp-ends-1)