(module solution racket
  (require srfi/1) ; For list-tabulate if needed, but vector is sufficient

  (define (minimum-number-of-operations-to-make-string-sorted s)
    (define MOD 1000000007)
    (define N (string-length s))

    ;; Precompute factorials modulo MOD
    (define fact (make-vector (+ N 1)))
    (vector-set! fact 0 1)
    (for ([i (in-range 1 (+ N 1))])
      (vector-set! fact i (modulo (* (vector-ref fact (- i 1)) i) MOD)))

    ;; Character counts
    ;; Since the problem states "No two characters in s are the same",
    ;; the counts will only be 0 or 1. This simplifies the divisor part
    ;; of the rank calculation, as product of factorials of counts will always be 1.
    (define counts (make-vector 26 0))
    (for ([char (string->list s)])
      (define char-code (- (char->integer char) (char->integer #\a)))
      (vector-set! counts char-code (+ (vector-ref counts char-code) 1)))

    (define ans 0)

    ;; Iterate through the string from left to right
    (for ([i (in-range N)])
      (define current-char-code (- (char->integer (string-ref s i)) (char->integer #\a)))

      ;; Calculate the number of characters to the right of s[i] (and currently available)
      ;; that are lexicographically smaller than s[i].
      (define num-smaller-chars 0)
      (for ([c-code (in-range current-char-code)])
        (set! num-smaller-chars (+ num-smaller-chars (vector-ref counts c-code))))

      ;; Calculate the contribution of this position to the total rank.
      ;; This is (num_smaller_chars * (N - 1 - i)! ) % MOD.
      ;; The division by product of factorials of character counts is not needed
      ;; because all character counts are 1 (as per problem statement: "No two characters are the same").
      (define term (modulo (* num-smaller-chars (vector-ref fact (- N 1 i))) MOD))

      (set! ans (modulo (+ ans term) MOD))

      ;; Mark the current character as used by decrementing its count.
      (vector-set! counts current-char-code (- (vector-ref counts current-char-code) 1)))

    ans))