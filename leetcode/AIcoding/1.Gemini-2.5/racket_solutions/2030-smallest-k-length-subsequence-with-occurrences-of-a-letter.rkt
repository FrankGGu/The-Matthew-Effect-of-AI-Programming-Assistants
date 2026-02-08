#lang racket

(define (smallest-k-length-subsequence-with-occurrences-of-a-letter s k letter repetition)
  (let* ((n (string-length s))
         (suffix-letter-counts (make-vector (+ n 1) 0)))

    ;; Precompute suffix-letter-counts
    ;; suffix-letter-counts[i] stores the count of 'letter' in s[i...n-1]
    (for ((i (range (- n 1) -1 -1)))
      (vector-set! suffix-letter-counts i
                   (+ (vector-ref suffix-letter-counts (+ i 1))
                      (if (char=? (string-ref s i) letter) 1 0))))

    (let loop ((i 0)
               (stack '()) ; Stack stores characters in reverse order (top is car)
               (stack-letter-count 0))
      (if (= i n)
          ;; End of string, return the result
          (list->string (reverse stack))
          ;; Process current character
          (let* ((char (string-ref s i))
                 (remaining-chars-in-s-after-current (- n 1 i)) ; Number of characters in s[i+1...n-1]
                 (remaining-letters-in-s-after-current (vector-ref suffix-letter-counts (+ i 1))) ; Count of 'letter' in s[i+1...n-1]
                 (current-char-is-letter (if (char=? char letter) 1 0)))

            ;; Pop phase: Remove elements from stack if 'char' is smaller,
            ;; AND we can still form a k-length subsequence,
            ;; AND we can still meet the 'repetition' constraint.
            (let pop-loop ((current-stack stack)
                           (current-stack-letter-count stack-letter-count))
              (if (and (not (null? current-stack))
                       (char<? char (car current-stack))
                       ;; Length constraint: Can we still reach k length after popping?
                       (>= (+ (length current-stack) remaining-chars-in-s-after-current) k)
                       ;; Repetition constraint: Can we still meet 'repetition' after popping?
                       (if (char=? (car current-stack) letter)
                           ;; If popped char is 'letter': check if (stack_letter_count - 1) + remaining_letters_in_s_after_current + (char_is_letter ? 1 : 0) >= repetition
                           (>= (+ (- current-stack-letter-count 1) remaining-letters-in-s-after-current current-char-is-letter) repetition)
                           ;; If popped char is not 'letter': check if stack_letter_count + remaining_letters_in_s_after_current + (char_is_letter ? 1 : 0) >= repetition
                           (>= (+ current-stack-letter-count remaining-letters-in-s-after-current current-char-is-letter) repetition)))
                  ;; Pop condition met, pop and recurse pop-loop
                  (let ((popped-char (car current-stack)))
                    (pop-loop (cdr current-stack)
                              (if (char=? popped-char letter)
                                  (- current-stack-letter-count 1)
                                  current-stack-letter-count)))
                  ;; Pop condition not met, or stack empty, or char not smaller, or cannot afford to pop
                  ;; Now decide whether to push 'char'
                  (let ((new-stack current-stack)
                        (new-stack-letter-count current-stack-letter-count))
                    (if (< (length new-stack) k)
                        ;; Stack not full, consider pushing 'char'
                        (if (char=? char letter)
                            ;; If 'char' is the target 'letter', always push if stack not full
                            (loop (+ i 1) (cons char new-stack) (+ new-stack-letter-count 1))
                            ;; If 'char' is not the target 'letter'
                            ;; Only push if we can still meet 'repetition' requirement with this non-'letter'
                            (if (>= (+ new-stack-letter-count remaining-letters-in-s-after-current current-char-is-letter) repetition)
                                (loop (+ i 1) (cons char new-stack) new-stack-letter-count)
                                ;; Cannot afford to add this non-'letter', skip it to save space for a needed 'letter'
                                (loop (+ i 1) new-stack new-stack-letter-count)))
                        ;; Stack is full, do not push
                        (loop (+ i 1) new-stack new-stack-letter-count))))))))))