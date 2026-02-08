#lang racket

(define (pyramid-transition bottom allowed)
  ;; Preprocess allowed transitions into a hash table
  ;; Key: (list char char) representing the bottom two chars
  ;; Value: (list char) representing possible top chars
  (define allowed-map (make-hash))
  (for-each (lambda (rule)
              (let* ((c1 (string-ref rule 0))
                     (c2 (string-ref rule 1))
                     (c3 (string-ref rule 2)))
                (hash-set! allowed-map (list c1 c2)
                           (cons c3 (hash-ref allowed-map (list c1 c2) '())))))
            allowed)

  ;; Memoization table for `can-build?`
  ;; Key: string (current-bottom)
  ;; Value: boolean (#t or #f)
  (define memo (make-hash))

  ;; Recursive helper function to check if a pyramid can be built from current-bottom
  (define (can-build? current-bottom)
    ;; Check memoization table first
    (cond ((hash-has-key? memo current-bottom)
           (hash-ref memo current-bottom))
          ;; Base case: If the bottom row has only one character, it's a valid pyramid
          ((= (string-length current-bottom) 1)
           (hash-set! memo current-bottom #t)
           #t)
          ;; Recursive step: Try to build the next row
          (else
           (let ((next-rows (generate-next-rows current-bottom allowed-map)))
             ;; If any of the possible next rows leads to a valid pyramid, return #t
             (let ((result (ormap can-build? next-rows)))
               (hash-set! memo current-bottom result)
               result)))))

  ;; Helper function to generate all possible next rows from current-bottom
  ;; Returns a list of strings
  (define (generate-next-rows current-bottom allowed-map)
    (let* ((n (string-length current-bottom))
           (all-next-rows '())) ; Accumulates all generated next row strings

      ;; This helper builds one next row at a time using backtracking
      ;; `idx`: current index in `current-bottom` we are considering for a pair
      ;; `current-next-row-chars`: list of characters collected for the next row so far (in reverse order)
      (define (build-next-row-combinations idx current-next-row-chars)
        (if (= idx (- n 1)) ;; Reached the end of pairs (n-1 pairs for a row of length n)
            ;; A complete next row has been formed
            (set! all-next-rows (cons (list->string (reverse current-next-row-chars)) all-next-rows))
            ;; Otherwise, consider the pair at `idx` and `idx + 1`
            (let* ((c1 (string-ref current-bottom idx))
                   (c2 (string-ref current-bottom (+ idx 1)))
                   (possible-top-chars (hash-ref allowed-map (list c1 c2) '())))
              ;; For each possible top character, recurse
              ;; If `possible-top-chars` is empty, `for-each` does nothing, which is correct.
              (for-each (lambda (top-char)
                          (build-next-row-combinations (+ idx 1) (cons top-char current-next-row-chars)))
                        possible-top-chars))))

      (build-next-row-combinations 0 '())
      (reverse all-next-rows))) ; Reverse to get the original generation order, though not strictly necessary for `ormap`

  ;; Start the process with the initial bottom row
  (can-build? bottom))