#lang racket

(define (minimum-time-to-revert-word-to-initial-state word k)
  (let* ((n (string-length word))
         (p 31) ; A prime base for hashing
         (m1 1000000007) ; A large prime modulus
         (m2 1000000009) ; Another large prime modulus for double hashing

         ;; Helper for modular exponentiation (base^exp % mod)
         (power (lambda (base exp mod)
                  (let loop ((b base) (e exp) (res 1))
                    (cond
                      ((zero? e) res)
                      ((odd? e) (loop (modulo (* b b) mod) (quotient e 2) (modulo (* res b) mod)))
                      (else (loop (modulo (* b b) mod) (quotient e 2) res))))))

         ;; Helper for modular inverse (a^(mod-2) % mod for prime mod)
         (modular-inverse (lambda (a mod)
                            (power a (- mod 2) mod)))

         ;; Precompute powers of p modulo m1 and m2
         (powers1 (make-vector (+ n 1)))
         (powers2 (make-vector (+ n 1)))
         (inv-p1 (modular-inverse p m1))
         (inv-p2 (modular-inverse p m2))
         (inv-powers1 (make-vector (+ n 1)))
         (inv-powers2 (make-vector (+ n 1)))

         ;; Precompute prefix hashes
         (prefix-hashes1 (make-vector (+ n 1) 0))
         (prefix-hashes2 (make-vector (+ n 1) 0)))

    ;; Initialize powers and inverse powers vectors
    (vector-set! powers1 0 1)
    (vector-set! powers2 0 1)
    (vector-set! inv-powers1 0 1)
    (vector-set! inv-powers2 0 1)
    (for ((i (in-range 1 (+ n 1))))
      (vector-set! powers1 i (modulo (* (vector-ref powers1 (- i 1)) p) m1))
      (vector-set! powers2 i (modulo (* (vector-ref powers2 (- i 1)) p) m2))
      (vector-set! inv-powers1 i (modulo (* (vector-ref inv-powers1 (- i 1)) inv-p1) m1))
      (vector-set! inv-powers2 i (modulo (* (vector-ref inv-powers2 (- i 1)) inv-p2) m2)))

    ;; Compute prefix hashes for the original word
    (for ((i (in-range n)))
      (let* ((char-val (- (char->integer (string-ref word i)) (char->integer #\a)))
             (prev-hash1 (vector-ref prefix-hashes1 i))
             (prev-hash2 (vector-ref prefix-hashes2 i)))
        (vector-set! prefix-hashes1 (+ i 1) (modulo (+ prev-hash1 (* char-val (vector-ref powers1 i))) m1))
        (vector-set! prefix-hashes2 (+ i 1) (modulo (+ prev-hash2 (* char-val (vector-ref powers2 i))) m2))))

    ;; Function to get hash of substring word[start...end-1]
    (define (get-substring-hash prefix-hashes powers inv-powers mod start end)
      (let* ((h (vector-ref prefix-hashes end))
             (h-prev (vector-ref prefix-hashes start))
             (sub (modulo (- h h-prev) mod)))
        (modulo (* sub (vector-ref inv-powers start)) mod)))

    ;; Original word's full hash
    (define original-hash1 (vector-ref prefix-hashes1 n))
    (define original-hash2 (vector-ref prefix-hashes2 n))

    ;; Helper to perform a full character-by-character comparison
    ;; This is called only when hashes match, to handle potential collisions
    (define (check-full-match current-shift)
      (let loop ((i 0))
        (cond
          ((= i n) #t) ; All characters matched
          ((char=? (string-ref word i) (string-ref word (modulo (+ i current-shift) n)))
           (loop (+ i 1)))
          (else #f))))

    ;; Iterate through operations (m)
    (let loop ((m 1))
      (let* ((current-shift (modulo (* m k) n)))
        (if (= current-shift 0)
            ;; If the effective shift is 0, the word is identical to the initial state
            m
            ;; Otherwise, calculate hashes of the shifted word
            (let* (;; Calculate hash of the suffix part (word[current-shift ... n-1])
                   (hash-suffix1 (get-substring-hash prefix-hashes1 powers1 inv-powers1 m1 current-shift n))
                   (hash-suffix2 (get-substring-hash prefix-hashes2 powers2 inv-powers2 m2 current-shift n))

                   ;; Calculate hash of the prefix part (word[0 ... current-shift-1])
                   (hash-prefix1 (get-substring-hash prefix-hashes1 powers1 inv-powers1 m1 0 current-shift))
                   (hash-prefix2 (get-substring-hash prefix-hashes2 powers2 inv-powers2 m2 0 current-shift))

                   ;; Combine hashes: H(suffix + prefix) = H(suffix) + H(prefix) * p^(length of suffix)
                   (shifted-hash1 (modulo (+ hash-suffix1 (* hash-prefix1 (vector-ref powers1 (- n current-shift)))) m1))
                   (shifted-hash2 (modulo (+ hash-suffix2 (* hash-prefix2 (vector-ref powers2 (- n current-shift)))) m2)))

              (if (and (= shifted-hash1 original-hash1)
                       (= shifted-hash2 original-hash2))
                  ;; Hashes match, perform full character comparison to confirm
                  (if (check-full-match current-shift)
                      m
                      (loop (+ m 1))) ; Collision or false positive, continue
                  ;; Hashes don't match, continue to next operation
                  (loop (+ m 1)))))))
    ))