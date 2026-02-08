#lang racket

(define (count-words-obtained-after-adding-a-letter startWords targetWords)
  ;; Helper function to canonicalize a word by sorting its characters.
  ;; This treats words as multisets of characters, ignoring their original order.
  (define (canonicalize-word word)
    (list->string (sort (string->list word) char<?)))

  ;; 1. Create a hash set of canonical forms of all startWords for efficient lookup.
  (define start-canonical-set
    (for/fold ((s (set)))
              ((word startWords))
      (set-add s (canonicalize-word word))))

  ;; 2. Initialize a counter for the number of target words found.
  (define count 0)

  ;; 3. Iterate through each target word.
  (for ((target-word targetWords))
    ;; Flag to stop checking current target-word once a match is found.
    (define found-match #f)

    ;; Iterate through each possible position to remove a character from the target word.
    (for ((i (range (string-length target-word))) #:unless found-match)
      ;; Convert the target word to a list of characters for easier manipulation.
      (define target-chars (string->list target-word))

      ;; Form a candidate start word by removing the character at index i.
      (define candidate-list-without-char
        (append (take target-chars i) (drop target-chars (+ i 1))))
      (define candidate-start-word-str (list->string candidate-list-without-char))

      ;; Canonicalize this candidate and check if it exists in our set of canonical start words.
      (when (set-member? start-canonical-set (canonicalize-word candidate-start-word-str))
        ;; If a match is found, increment the count and set the flag to move to the next target word.
        (set! count (+ count 1))
        (set! found-match #t))))

  ;; 4. Return the total count of target words that can be obtained.
  count)