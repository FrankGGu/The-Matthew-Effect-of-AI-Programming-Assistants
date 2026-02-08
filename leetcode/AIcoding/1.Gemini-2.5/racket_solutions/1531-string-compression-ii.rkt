#lang racket

(define (get-len count)
  (cond
    ((= count 0) 0)
    ((= count 1) 1)
    ((< count 10) 2)   ; e.g., "a2" for count 2-9
    ((< count 100) 3)  ; e.g., "a10" for count 10-99
    (else 4)))         ; e.g., "a100" for count >= 100 (max possible count for n=100 is 100)

(define (get-length-of-compressed s k)
  (define n (string-length s))
  (define memo (make-hasheq)) ; Memoization table to store (idx . k-rem) -> min-length

  ;; A value larger than any possible compressed string length.
  ;; The maximum possible compressed length for a string of length 'n' is 'n' itself 
  ;; (e.g., if all characters are unique and no deletions are made).
  ;; So, (add1 n) is a safe infinity value.
  (define INF (add1 n)) 

  ;; Recursive helper function with memoization
  ;; dp idx k-rem: minimum length to compress the suffix s[idx:] after
  ;;               deleting at most k-rem characters.
  (define (dp idx k-rem)
    (cond
      ((< k-rem 0) INF) ; If we've used more deletions than allowed, this path is invalid
      ((= idx n) 0)     ; If we've processed the entire string, compressed length is 0
      ;; If the number of remaining characters (n - idx) is less than or equal to 
      ;; the allowed deletions (k-rem), we can delete all of them, resulting in 0 length.
      ((<= (- n idx) k-rem) 0) 
      (else
       (let ((key (cons idx k-rem))) ; Create a key for memoization (pair of idx and k-rem)
         (case (hash-has-key? memo key)
           ((#t) (hash-ref memo key)) ; If already computed, return memoized value
           (else
            (let ((min-len INF))
              ;; Option 1: Delete the character at s[idx]
              (set! min-len (min min-len (dp (+ idx 1) (- k-rem 1))))

              ;; Option 2: Keep s[idx] and form a block starting with s[idx]
              ;; Iterate through all possible ending positions 'j' for this block.
              (let ((char-to-match (string-ref s idx)) ; The character that defines this block
                    (same-count 0) ; Count of 'char-to-match' in s[idx...j]
                    (diff-count 0)) ; Count of other characters in s[idx...j]

                (for ([j (in-range idx n)]) ; j is the end index (inclusive) of the current block
                  (let ((current-char (string-ref s j)))
                    (if (char=? current-char char-to-match)
                        (set! same-count (+ same-count 1))
                        (set! diff-count (+ diff-count 1))))

                  ;; If we have enough deletions (k-rem) to remove all 'diff-count' characters
                  (when (>= k-rem diff-count)
                    (let ((current-block-compressed-len (get-len same-count)))
                      (set! min-len (min min-len
                                         (+ current-block-compressed-len
                                            (dp (+ j 1) (- k-rem diff-count)))))))))
              (hash-set! memo key min-len) ; Store the computed result in memo
              min-len))))))

  (dp 0 k)) ; Start the DP from index 0 with initial k deletions allowed