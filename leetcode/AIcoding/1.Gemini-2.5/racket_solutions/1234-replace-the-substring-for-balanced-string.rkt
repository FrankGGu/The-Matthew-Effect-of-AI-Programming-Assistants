#lang racket

(define (replace-substring-for-balanced-string s)
  (define n (string-length s))
  (define k (/ n 4))

  ;; Helper to create a frequency map initialized with zeros for Q, W, E, R
  (define (make-char-freq-map)
    (hash #\Q 0 #\W 0 #\E 0 #\R 0))

  ;; Calculate overall frequencies of characters in the string s
  (define overall-freq (make-char-freq-map))
  (for ([char (in-string s)])
    (hash-set! overall-freq char (add1 (hash-ref overall-freq char 0))))

  ;; Calculate the minimum required counts for each character within the sliding window.
  ;; A character 'c' needs to be in the window if its overall count exceeds k.
  ;; The number of 'c's needed in the window is (overall-freq[c] - k).
  (define required-in-window (make-char-freq-map))
  (for ([char '(#\Q #\W #\E #\R)])
    (define excess (- (hash-ref overall-freq char) k))
    (when (> excess 0)
      (hash-set! required-in-window char excess)))

  ;; Predicate to check if the current window is "valid".
  ;; A window is valid if it contains at least the 'required-in-window' count
  ;; for every character.
  (define (check-valid-window window-freq)
    (for/and ([char '(#\Q #\W #\E #\R)])
      (>= (hash-ref window-freq char 0) (hash-ref required-in-window char 0))))

  (define left 0)
  (define min-len n) ; Initialize min-len to the maximum possible length (n)
  (define window-freq (make-char-freq-map)) ; Frequency map for the current sliding window

  ;; Iterate with 'right' pointer to expand the window
  (for ([right (in-range n)])
    (define current-char (string-ref s right))
    ;; Add current character to window frequency
    (hash-set! window-freq current-char (add1 (hash-ref window-freq current-char 0)))

    ;; Use a named let for the inner loop to shrink the window from the 'left'
    (let loop ()
      ;; While the current window is valid (i.e., satisfies the condition)
      (when (check-valid-window window-freq)
        ;; Update min-len with the current valid window's length
        (set! min-len (min min-len (+ (- right left) 1)))

        ;; Shrink the window from the left by removing s[left]
        ;; This step is only valid if left is still within the window (left <= right)
        (when (<= left right)
          (define char-to-remove (string-ref s left))
          (hash-set! window-freq char-to-remove (sub1 (hash-ref window-freq char-to-remove 0)))
          (set! left (add1 left))
          (loop)))) ; Continue shrinking if still valid
    )

  min-len)