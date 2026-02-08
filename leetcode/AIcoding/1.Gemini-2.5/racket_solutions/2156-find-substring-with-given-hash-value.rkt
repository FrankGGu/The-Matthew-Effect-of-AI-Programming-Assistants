#lang racket

(define (find-substring-with-given-hash-value s power modulo k hashValue)
  (define N (string-length s))

  ;; Helper for modular exponentiation (base^exp % mod)
  (define (mod-exp base exp mod)
    (let loop ((b base) (e exp) (res 1))
      (cond
        ((zero? e) res)
        ((odd? e) (loop (remainder (* b b) mod) (quotient e 2) (remainder (* res b) mod)))
        (else (loop (remainder (* b b) mod) (quotient e 2) res)))))

  ;; Calculate (char - 'a' + 1)
  (define (char-to-val c)
    (+ (- (char->integer c) (char->integer #\a)) 1))

  ;; Precompute power^(k-1) % modulo
  ;; This is the coefficient for the leftmost character in the hash formula
  (define power-k-minus-1 (mod-exp power (- k 1) modulo))

  ;; Precompute modular inverse of power (power^(modulo-2) % modulo)
  ;; Used for division in rolling hash. Modulo is prime (10^9 + 7).
  (define power-inv (mod-exp power (- modulo 2) modulo))

  ;; Step 1: Calculate the hash for the rightmost substring s[N-k ... N-1]
  (let initial-hash-loop ((j (- N 1)) ; current char index, starting from rightmost of string
                          (current-hash 0)
                          (current-power-of-P 1)) ; P^0, P^1, P^2, ...
    (if (< j (- N k)) ; When j reaches N-k-1, we have processed chars from N-1 down to N-k
        ;; Base case for initial hash loop: hash for s[N-k ... N-1] is computed
        (let ((result-idx (- N k))) ; Initial candidate for the answer
          (if (= current-hash hashValue)
              result-idx ; Found a match, this is the rightmost possible answer
              ;; Step 2: Roll the hash backwards from s[N-k-1 ... N-2] down to s[0 ... k-1]
              (let roll-loop ((curr-i (- N k 1)) ; Starting index of current window (moving left)
                              (curr-hash current-hash)
                              (res-idx result-idx)) ; Stores the leftmost index found so far
                (cond
                  ((< curr-i 0) res-idx) ; All substrings checked
                  (else
                   ;; Character to remove from the right end of the window (s[curr-i + k])
                   (define char-to-remove-val (char-to-val (string-ref s (+ curr-i k))))
                   ;; Character to add to the left end of the window (s[curr-i])
                   (define char-to-add-val (char-to-val (string-ref s curr-i)))

                   ;; Rolling hash formula for moving window left:
                   ;; H_new = ((H_old - val(s[old_rightmost]) * P^0) * P_inv + val(s[new_leftmost]) * P^(k-1)) % M
                   (define new-hash
                     (let* ((term-remove (remainder (* char-to-remove-val 1) modulo)) ; P^0 is 1
                            (temp-sub (remainder (- curr-hash term-remove) modulo))
                            (temp-pos (remainder (+ temp-sub modulo) modulo)) ; Ensure positive result
                            (temp-div (remainder (* temp-pos power-inv) modulo))
                            (term-add (remainder (* char-to-add-val power-k-minus-1) modulo))
                            (final-hash (remainder (+ temp-div term-add) modulo)))
                       final-hash))

                   (roll-loop (- curr-i 1)
                              new-hash
                              (if (= new-hash hashValue) curr-i res-idx)))))))
        ;; Recursive step for initial hash calculation (building hash for s[N-k ... N-1])
        (let* ((char-val (char-to-val (string-ref s j)))
               (term (remainder (* char-val current-power-of-P) modulo)))
          (initial-hash-loop (- j 1)
                             (remainder (+ current-hash term) modulo)
                             (remainder (* current-power-of-P power) modulo))))))