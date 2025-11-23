#lang racket

(define (max-occurrences s maxLetters minSize maxSize)
  (define n (string-length s))

  (define counts (make-hash))
  (define max-occ 0)

  ;; freq: frequency array for characters 'a' through 'z'
  ;; unique-chars: count of unique characters in the current window
  (define freq (make-vector 26 0))
  (define unique-chars 0)

  ;; Helper to convert a character to its 0-25 index
  (define (char-to-idx c)
    (- (char->integer c) (char->integer #\a)))

  ;; Only proceed if a window of size minSize can be formed
  (when (>= n minSize)
    ;; Initialize the first window (substring s[0 ... minSize-1])
    (for ([k (in-range minSize)])
      (define char-idx (char-to-idx (string-ref s k)))
      (when (= (vector-ref freq char-idx) 0)
        (set! unique-chars (+ unique-chars 1)))
      (vector-set! freq char-idx (+ (vector-ref freq char-idx) 1)))

    ;; Slide the window across the string
    ;; i is the starting index of the current window
    (for ([i (in-range (- n minSize) #t)]) ; Iterate i from 0 up to n - minSize (inclusive)
      (define current-substring (substring s i (+ i minSize)))

      ;; Check if the current substring satisfies the maxLetters constraint
      (when (<= unique-chars maxLetters)
        ;; Increment its count in the hash map
        (define current-count (+ (hash-ref counts current-substring 0) 1))
        (hash-set! counts current-substring current-count)
        ;; Update the overall maximum occurrences found so far
        (set! max-occ (max max-occ current-count)))

      ;; Prepare for the next window:
      ;; This block runs if there is a next window to consider 
      ;; (i.e., i is not the last possible starting index)
      (when (< (+ i 1) (- n minSize)) ; Equivalent to i < (n - minSize)
        ;; Remove the character leaving the window from the left (s[i])
        (define char-to-remove-idx (char-to-idx (string-ref s i)))
        (vector-set! freq char-to-remove-idx (- (vector-ref freq char-to-remove-idx) 1))
        (when (= (vector-ref freq char-to-remove-idx) 0)
          (set! unique-chars (- unique-chars 1)))

        ;; Add the character entering the window from the right (s[i + minSize])
        (define char-to-add-idx (char-to-idx (string-ref s (+ i minSize))))
        (when (= (vector-ref freq char-to-add-idx) 0)
          (set! unique-chars (+ unique-chars 1)))
        (vector-set! freq char-to-add-idx (+ (vector-ref freq char-to-add-idx) 1))))
  )

  max-occ)