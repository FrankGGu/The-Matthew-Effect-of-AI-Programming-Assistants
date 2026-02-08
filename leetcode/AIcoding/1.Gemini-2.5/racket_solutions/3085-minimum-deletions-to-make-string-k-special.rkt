#lang racket

(define (minimum-deletions-to-make-k-special s k)
  ;; 1. Count character frequencies
  (define freqs (make-vector 26 0)) ; Use a vector for mutable counts

  (for-each
   (lambda (c)
     (define idx (- (char->integer c) (char->integer #\a)))
     (vector-set! freqs idx (+ (vector-ref freqs idx) 1)))
   (string->list s))

  ;; 2. Collect unique non-zero frequencies
  ;; Convert vector to list to easily filter, remove-duplicates, and sort
  (define all-freq-values (vector->list freqs))
  (define unique-non-zero-freqs
    (remove-duplicates (filter (lambda (f) (> f 0)) all-freq-values)))

  ;; Add k to the unique frequencies and sort them.
  ;; These are the potential minimum frequencies for characters we keep.
  (define possible-target-min-freqs
    (sort (remove-duplicates (cons k unique-non-zero-freqs)) <))

  ;; 3. Initialize minimum deletions
  (define min-deletions (string-length s)) ; Max possible deletions is deleting all characters

  ;; 4. Iterate through possible target-min-freq values
  (for-each
   (lambda (target-min-freq)
     ;; We only care about target-min-freq values that are at least k
     ;; because the problem states "frequency of each character ... is either 0 or at least k".
     (when (>= target-min-freq k)
       (define current-deletions 0)
       ;; Calculate deletions for this target-min-freq
       (for-each
        (lambda (freq)
          ;; If a character's original frequency is positive, we decide whether to delete it
          (when (> freq 0)
            ;; If its frequency is less than our chosen target-min-freq,
            ;; we must delete all occurrences of this character.
            (when (< freq target-min-freq)
              (set! current-deletions (+ current-deletions freq)))))
        all-freq-values) ; Use the list of all frequencies

       ;; Update the overall minimum deletions
       (set! min-deletions (min min-deletions current-deletions))))
   possible-target-min-freqs)

  min-deletions)