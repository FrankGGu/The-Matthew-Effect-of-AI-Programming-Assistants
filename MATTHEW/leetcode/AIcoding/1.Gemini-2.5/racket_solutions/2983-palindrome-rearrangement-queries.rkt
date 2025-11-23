#lang racket

(define (palindrome-rearrangement-queries s queries)
  (define n (string-length s))

  (define prefix-xor (make-vector (+ n 1) 0))
  (for ([i (in-range n)])
    (define char-code (- (char->integer (string-ref s i)) (char->integer #\a)))
    (vector-set! prefix-xor (+ i 1) (bitwise-xor (vector-ref prefix-xor i) (arithmetic-shift 1 char-code))))

  (define (popcount n)
    (let loop ([num n] [count 0])
      (if (zero? num)
          count
          (loop (bitwise-and num (sub1 num)) (+ count 1)))))

  (define (is-palindrome-mask? mask)
    (<= (popcount mask) 1))

  (define (can-be-palindrome-with-k-changes? combined-mask k)
    (<= (floor (/ (popcount combined-mask) 2)) k))

  (define results (make-list (length queries) #f))
  (for ([q-idx (in-range (length queries))])
    (define q (list-ref queries q-idx))
    (define l1 (list-ref q 0))
    (define r1 (list-ref q 1))
    (define l2 (list-ref q 2))
    (define r2 (list-ref q 3))
    (define k (list-ref q 4))

    (define mask1 (bitwise-xor (vector-ref prefix-xor (+ r1 1)) (vector-ref prefix-xor l1)))
    (define mask2 (bitwise-xor (vector-ref prefix-xor (+ r2 1)) (vector-ref prefix-xor l2)))

    (define cond1 (is-palindrome-mask? mask1))
    (define cond2 (is-palindrome-mask? mask2))

    (define combined-mask (bitwise-xor mask1 mask2))
    (define cond3 (can-be-palindrome-with-k-changes? combined-mask k))

    (list-set! results q-idx (and cond1 cond2 cond3)))
  results)