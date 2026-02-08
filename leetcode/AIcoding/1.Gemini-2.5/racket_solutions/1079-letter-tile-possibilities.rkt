(define (num-tile-possibilities tiles)
  (define counts (make-vector 26 0)) ; Frequencies of 'a' through 'z'

  ; Populate counts for each character in the input string
  (for ([char (string->list tiles)])
    (let* ([idx (- (char->integer char) (char->integer #\a))]
           [current-count (vector-ref counts idx)])
      (vector-set! counts idx (+ current-count 1))))

  (define result-set (make-hash)) ; Use a hash table as a set to store unique sequences (keys are strings, values are #t)

  ; Backtracking function to generate sequences
  ; current-chars is a list of characters forming the current sequence, built in reverse order
  (define (backtrack current-chars)
    ; If current-chars is not empty, it means we have formed a valid sequence.
    ; Convert it to a string (reversing it first) and add to the result-set.
    (when (not (empty? current-chars))
      (hash-set! result-set (list->string (reverse current-chars)) #t))

    ; Iterate through all possible characters from 'a' to 'z'
    (for ([i (in-range 26)])
      (when (> (vector-ref counts i) 0) ; Check if the character (at index i) is available
        ; Use the character:
        (vector-set! counts i (- (vector-ref counts i) 1)) ; Decrement its count
        ; Recursively call backtrack with the character added to the current sequence
        (backtrack (cons (integer->char (+ (char->integer #\a) i)) current-chars))
        ; Backtrack: restore the character's count for other branches
        (vector-set! counts i (+ (vector-ref counts i) 1)))))

  (backtrack '()) ; Start the backtracking process with an empty sequence
  (hash-count result-set)) ; The final answer is the number of unique sequences found