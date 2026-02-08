#lang racket

(define (get-smallest-string s)
  (let* ((n (string-length s))
         (char-vec (string->vector s)) ; Convert string to mutable vector of characters
         (start-idx -1))

    ;; Find the first character that is not 'a'
    (for ([i (in-range n)])
      (when (and (= start-idx -1) (not (char=? (vector-ref char-vec i) #\a)))
        (set! start-idx i)))

    ;; If all characters are 'a', no operation can be performed according to the rule
    ;; 'a' cannot be changed. Return the original string.
    (when (= start-idx -1)
      (if (= n 0) "" s)) ; Handle empty string edge case

    ;; If a character not 'a' is found, perform the operation
    (when (not (= start-idx -1))
      (for ([i (in-range start-idx n)])
        (let ((current-char (vector-ref char-vec i)))
          (if (not (char=? current-char #\a))
              (vector-set! char-vec i (integer->char (- (char->integer current-char) 1)))
              (break))))) ; Stop the operation if 'a' is encountered

    (vector->string char-vec)))