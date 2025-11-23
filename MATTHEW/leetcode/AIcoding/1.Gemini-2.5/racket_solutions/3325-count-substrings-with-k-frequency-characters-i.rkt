#lang racket

(define (count-substrings-with-k-frequency s k)
  (define n (string-length s))
  (define total-count 0)

  (for ([i (in-range n)])
    (define freq-map (make-hash))
    (define unique-chars 0)
    (define chars-meeting-k-freq 0)

    (for ([j (in-range i n)])
      (define char (string-ref s j))
      (define old-freq (hash-ref freq-map char 0))
      (define new-freq (+ old-freq 1))
      (hash-set! freq-map char new-freq)

      ; Update count of unique characters
      (when (= old-freq 0)
        (set! unique-chars (+ unique-chars 1)))

      ; Update count of unique characters whose frequency is at least k
      ; Increment if the character's frequency just reached or surpassed k
      (when (and (< old-freq k) (>= new-freq k))
        (set! chars-meeting-k-freq (+ chars-meeting-k-freq 1)))

      ; Note: The chars-meeting-k-freq will not decrement in this inner loop
      ; because we are only extending the substring by adding characters,
      ; so new-freq is always old-freq + 1. If old-freq was already >= k,
      ; then new-freq will also be >= k.

      ; If all unique characters in the current substring s[i...j]
      ; have a frequency of at least k, then it's a valid substring.
      (when (= unique-chars chars-meeting-k-freq)
        (set! total-count (+ total-count 1))))
  )
  total-count)