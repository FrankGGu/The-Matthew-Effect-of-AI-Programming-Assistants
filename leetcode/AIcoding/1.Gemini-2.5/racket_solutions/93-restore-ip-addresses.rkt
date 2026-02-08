#lang racket

(define (restore-ip-addresses s)
  (define result '())
  (define s-len (string-length s))

  ;; Early exit for string lengths that cannot form a valid IP address
  (when (or (< s-len 4) (> s-len 12))
    (set! result '())
    (void))

  ;; Helper function to check if a segment is valid
  (define (is-valid-segment? seg)
    (let ((len (string-length seg)))
      (cond
        ((or (= len 0) (> len 3)) #f) ; Segment must be 1 to 3 characters long
        ((and (> len 1) (char=? (string-ref seg 0) #\0)) #f) ; No leading zeros unless the segment is "0" itself
        (else
         (let ((val (string->number seg)))
           (and val (>= val 0) (<= val 255))))))) ; Value must be between 0 and 255

  ;; Backtracking function
  ;; current-index: The starting index for the next segment in the string s
  ;; current-parts: A list of segments formed so far (in reverse order for efficient consing)
  (define (backtrack current-index current-parts)
    (cond
      ;; Base case 1: Four parts have been formed
      ((= (length current-parts) 4)
       ;; If all characters from s have been consumed, it's a valid IP address
       (when (= current-index s-len)
         (set! result (cons (string-join (reverse current-parts) ".") result))))

      ;; Base case 2: Ran out of string characters or exceeded string length
      ;; before forming 4 parts. This path is invalid.
      ((>= current-index s-len) #f) 

      ;; Recursive step: Try forming the next segment
      (else
       (for ([len (in-range 1 4)]) ; Try segments of length 1, 2, or 3
         (let ((end-index (+ current-index len)))
           ;; Ensure the segment does not go beyond the string bounds
           (when (<= end-index s-len)
             (let* ((segment (substring s current-index end-index)))
               ;; If the segment is valid, recurse with the next state
               (when (is-valid-segment? segment)
                 (backtrack end-index (cons segment current-parts)))))))))))

  ;; Start the backtracking process from the beginning of the string with an empty list of parts
  (backtrack 0 '())

  ;; The 'result' list is built by 'cons', so it's in reverse order of discovery.
  ;; Reverse it to get the expected order (often lexicographical or consistent discovery order).
  (reverse result))