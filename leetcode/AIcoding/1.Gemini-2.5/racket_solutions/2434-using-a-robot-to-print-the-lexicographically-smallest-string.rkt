#lang racket

(define (robot-print s)
  (let* ((n (string-length s))
         (s-chars (string->list s))
         ;; min-suffix[i] stores the minimum character in s[i...n-1]
         ;; min-suffix will be a list of chars, indexed from 0 to n
         ;; min-suffix[n] is a sentinel (e.g., #\z, larger than any possible input char)
         (min-suffix (make-list (+ n 1) #\z)))

    ;; Compute min-suffix array
    ;; Iterate from n-1 down to 0
    (for ((i (range (- n 1) -1 -1)))
      (list-set! min-suffix i
                 (char-min (list-ref s-chars i)
                           (list-ref min-suffix (+ i 1)))))

    ;; Outer loop processes characters from the input string s
    ;; Inner loop handles popping from the buffer
    (let outer-loop ((idx 0)                ; Current index in s-chars
                     (buffer '())           ; Stack for buffer (list, top is car)
                     (result-chars '()))    ; List of characters for the result string (built in reverse)
      (cond
        ((= idx n) ; All characters from s have been processed
         ;; Pop any remaining characters from the buffer
         ;; buffer is a stack, so its elements are in reverse order of how they should be appended.
         ;; result-chars was built in reverse, so (reverse result-chars) gives the prefix.
         ;; (reverse buffer) gives the suffix.
         (list->string (append (reverse result-chars) (reverse buffer))))

        (else
         ;; Inner loop to repeatedly pop from buffer if conditions met
         (let inner-loop ((current-idx idx)
                          (current-buffer buffer)
                          (current-result result-chars))
           ;; min-char-in-s is the minimum character in the remaining part of s (s[current-idx ... n-1])
           (let ((min-char-in-s (list-ref min-suffix current-idx)))
             (cond
               ;; Condition to pop from buffer:
               ;; 1. Buffer is not empty.
               ;; 2. The character at the top of the buffer is less than or equal to
               ;;    the smallest character remaining in the input string s.
               ((and (not (empty? current-buffer))
                     (char<=? (car current-buffer) min-char-in-s))
                ;; Pop from buffer and append to result (in reverse order for efficiency)
                ;; Then re-evaluate the inner loop with the updated buffer and result, without advancing idx.
                (inner-loop current-idx
                            (cdr current-buffer)
                            (cons (car current-buffer) current-result)))
               (else
                ;; If the condition to pop is not met, push the current character from s to the buffer.
                ;; Then advance idx and restart the outer loop.
                (outer-loop (+ current-idx 1)
                            (cons (list-ref s-chars current-idx) current-buffer)
                            current-result)))))))))