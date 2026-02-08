#lang racket

(define (longest-duplicate-substring s)
  (define n (string-length s))
  (when (< n 2)
    "") ; If n=0 or n=1, no duplicate substring is possible, return empty string

  (define base 31) ; A prime number greater than alphabet size (26 for lowercase English)
  (define modulus 1000000007) ; A large prime modulus

  ; Helper to get character value (a=0, b=1, ...)
  (define (char->int c)
    (- (char->integer c) (char->integer #\a)))

  ; Function to check if a duplicate substring of length 'len' exists.
  ; Returns (values #t start-index) if found, (values #f -1) otherwise.
  ; 'start-index' is the starting position of one of the duplicate substrings.
  (define (check len)
    (when (= len 0) (values #t 0)) ; A length 0 substring always duplicates (empty string at index 0)

    (define current-hash 0)
    (define power-base-len-minus-1 1) ; base^(len-1) mod modulus

    ; Precompute power-base-len-minus-1
    (for ([i (in-range 0 (- len 1))])
      (set! power-base-len-minus-1 (modulo (* power-base-len-minus-1 base) modulus)))

    ; Calculate hash for the first substring s[0...len-1]
    (for ([i (in-range 0 len)])
      (set! current-hash (modulo (+ (* current-hash base) (char->int (string-ref s i))) modulus)))

    ; Map hash to a list of starting indices
    ; Using a hash table to store (hash -> list-of-indices)
    (define hash-map (make-hash))
    (hash-set! hash-map current-hash (list 0))

    ; Rolling hash for subsequent substrings
    ; i represents the starting index of the current substring
    (for ([i (in-range 1 (- n len))]) ; Iterate from s[1...len] to s[n-len...n-1]
      ; Remove s[i-1] from hash
      (define char-to-remove-val (char->int (string-ref s (- i 1))))
      (define term-to-subtract (modulo (* char-to-remove-val power-base-len-minus-1) modulus))
      (set! current-hash (modulo (- current-hash term-to-subtract) modulus))
      (when (< current-hash 0) (set! current-hash (+ current-hash modulus))) ; Ensure positive result from modulo

      ; Add s[i+len-1] to hash
      (define char-to-add-val (char->int (string-ref s (+ i len -1))))
      (set! current-hash (modulo (+ (* current-hash base) char-to-add-val) modulus))

      ; Check for duplicates
      (define existing-indices (hash-ref hash-map current-hash '()))
      (for ([prev-idx existing-indices])
        ; Verify actual substrings to avoid hash collisions (false positives)
        (when (string=? (substring s prev-idx (+ prev-idx len))
                        (substring s i (+ i len)))
          (values #t i))) ; Found a true duplicate, return true and its starting index

      ; Add current index to map
      (hash-set! hash-map current-hash (cons i existing-indices)))

    (values #f -1)) ; No duplicate of this length found

  ; Binary search for the longest duplicate substring length
  (define low 0)
  (define high (- n 1)) ; Max possible length is n-1 (e.g., "aaaaa" -> "aaaa")
  (define ans-len 0)
  (define ans-start-idx 0)

  (while (<= low high)
    (define mid (quotient (+ low high) 2))
    (define-values (found? start-idx) (check mid))
    (if found?
        (begin
          (set! ans-len mid)
          (set! ans-start-idx start-idx)
          (set! low (+ mid 1))) ; Try for a longer duplicate
        (set! high (- mid 1)))) ; Duplicate too long, try shorter

  (substring s ans-start-idx (+ ans-start-idx ans-len)))