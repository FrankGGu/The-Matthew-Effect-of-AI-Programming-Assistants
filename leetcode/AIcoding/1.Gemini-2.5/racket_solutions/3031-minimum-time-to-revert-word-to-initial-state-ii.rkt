#lang racket

(define (minimum-time-to-revert-word-to-initial-state word k)
  (define n (string-length word))

  ;; Polynomial hashing setup with two bases and moduli to reduce collision probability
  (define P1 31) ; Base 1
  (define M1 1000000007) ; Modulo 1
  (define P2 37) ; Base 2
  (define M2 1000000009) ; Modulo 2

  ;; Precompute powers of P1 and P2
  ;; powers1[i] stores P1^i mod M1
  ;; powers2[i] stores P2^i mod M2
  (define powers1 (make-vector (+ n 1)))
  (define powers2 (make-vector (+ n 1)))
  (vector-set! powers1 0 1)
  (vector-set! powers2 0 1)
  (for ([i (in-range 1 (+ n 1))])
    (vector-set! powers1 i (modulo (* (vector-ref powers1 (- i 1)) P1) M1))
    (vector-set! powers2 i (modulo (* (vector-ref powers2 (- i 1)) P2) M2)))

  ;; Precompute prefix hashes
  ;; hashes1[i] stores hash of word[0 ... i-1] mod M1
  ;; hashes2[i] stores hash of word[0 ... i-1] mod M2
  (define hashes1 (make-vector (+ n 1) 0))
  (define hashes2 (make-vector (+ n 1) 0))
  (for ([i (in-range n)])
    (vector-set! hashes1 (+ i 1) (modulo (+ (* (vector-ref hashes1 i) P1) (char->integer (string-ref word i))) M1))
    (vector-set! hashes2 (+ i 1) (modulo (+ (* (vector-ref hashes2 i) P2) (char->integer (string-ref word i))) M2)))

  ;; Function to get hash of substring word[start ... end-1]
  ;; h-vec: prefix hash vector
  ;; p-vec: powers vector
  ;; m: modulo
  ;; start: 0-indexed start of substring (inclusive)
  ;; end: 0-indexed end of substring (exclusive)
  (define (get-hash h-vec p-vec m start end)
    (let* ([len (- end start)]
           [h-end (vector-ref h-vec end)]
           [h-start (vector-ref h-vec start)]
           [p-len (vector-ref p-vec len)]
           [val (modulo (- h-end (modulo (* h-start p-len) m)) m)])
      (if (< val 0) (+ val m) val)))

  ;; Iterate t (number of operations) starting from 0
  (let loop ([t 0])
    (let* ([chars-removed (* t k)]
           [remaining-len (- n chars-removed)])

      ;; The problem condition:
      ;; "The word is considered to be in its initial state if it is a prefix of the original word."
      ;; "it" refers to the current state of the word, which is the suffix of the original word
      ;; starting at index `chars-removed` (i.e., `word[chars-removed ... n-1]`).
      ;; So, we check if `word[chars-removed ... n-1]` is equal to `word[0 ... remaining-len-1]`.

      (if (<= remaining-len 0)
          ;; If remaining-len is 0 or less, the "current word" (the suffix) is an empty string.
          ;; An empty string is always a prefix of any string (including the original word).
          ;; Thus, this `t` satisfies the condition.
          t
          ;; Otherwise, compare hashes of the two substrings
          (let* ([hash1-prefix (get-hash hashes1 powers1 M1 0 remaining-len)]
                 [hash2-prefix (get-hash hashes2 powers2 M2 0 remaining-len)]
                 [hash1-suffix (get-hash hashes1 powers1 M1 chars-removed n)]
                 [hash2-suffix (get-hash hashes2 powers2 M2 chars-removed n)])

            (if (and (= hash1-prefix hash1-suffix)
                     (= hash2-prefix hash2-suffix))
                ;; If both hashes match, the substrings are considered equal.
                ;; This `t` is the minimum number of operations.
                t
                ;; If hashes don't match, increment t and continue the loop.
                (loop (+ t 1))))))))