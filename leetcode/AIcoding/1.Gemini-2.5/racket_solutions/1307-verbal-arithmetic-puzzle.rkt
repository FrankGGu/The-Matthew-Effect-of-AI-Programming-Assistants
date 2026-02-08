#lang racket

(define (is-solvable words result)
  ;; Combine all strings to find unique characters and leading characters
  (define all-strings (append words (list result)))

  ;; Collect all unique characters and sort them for deterministic processing order
  (define unique-chars-set (make-hash-set))
  (for-each (lambda (s)
              (for-each (lambda (c) (hash-set-add! unique-chars-set c)) (string->list s)))
            all-strings)
  (define unique-chars (sort (hash-set->list unique-chars-set) char<?))

  ;; Identify characters that appear as the first letter of any word or the result.
  ;; These characters cannot be mapped to 0 if the word/result has length greater than 1.
  (define leading-chars (make-hash-set))
  (for-each (lambda (s)
              (when (> (string-length s) 1)
                (hash-set-add! leading-chars (string-ref s 0))))
            all-strings)

  ;; Mutable hash table to store character to digit mappings
  (define char-to-digit (make-hash)) ; char -> int

  ;; Mutable vector to track which digits (0-9) have been used
  (define digit-used (make-vector 10 #f)) ; int -> boolean

  ;; Helper function to convert a string to its integer value
  ;; based on the current char-to-digit mapping
  (define (string-val s)
    (let loop ((i 0) (val 0))
      (if (= i (string-length s))
          val
          (loop (+ i 1)
                (+ (* val 10) (hash-ref char-to-digit (string-ref s i)))))))

  ;; Depth-First Search (DFS) backtracking function
  ;; char-idx: index of the current unique character to assign a digit to
  (define (dfs char-idx)
    ;; Base case: All unique characters have been assigned digits
    (if (= char-idx (length unique-chars))
        ;; Evaluate the arithmetic puzzle
        (let ((sum-words (apply + (map string-val words)))
              (result-val (string-val result)))
          (= sum-words result-val)) ; Return true if the equation holds
        ;; Recursive step: Try to assign a digit to the current character
        (let ((current-char (list-ref unique-chars char-idx)))
          ;; Iterate through possible digits (0-9)
          (let loop-digits ((digit 0))
            (cond
              ((= digit 10) #f) ; Tried all digits for current-char, no solution found
              ;; Check constraints:
              ;; 1. The digit must not be already used by another character.
              ;; 2. If the current character is a leading character, it cannot be 0.
              ((or (vector-ref digit-used digit)
                   (and (= digit 0) (hash-set-member? leading-chars current-char)))
               (loop-digits (+ digit 1))) ; Skip this digit, try the next one
              (else
               ;; Make a choice: Assign the current digit to the current character
               (hash-set! char-to-digit current-char digit)
               (vector-set! digit-used digit #t)

               ;; Recurse: Try to assign digits to the next character
               (if (dfs (+ char-idx 1))
                   #t ; If a solution is found in the recursive call, propagate true
                   ;; Backtrack: If the recursive call didn't lead to a solution,
                   ;; undo the current choice and try the next digit
                   (begin
                     (hash-remove! char-to-digit current-char)
                     (vector-set! digit-used digit #f)
                     (loop-digits (+ digit 1))))))))))

  ;; Start the DFS from the first unique character (index 0)
  (dfs 0))