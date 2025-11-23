#lang racket

(define (minimum-deletions-for-at-most-k-distinct-characters s k)
  ;; Create a hash map to store character frequencies
  (define freq-map (make-hash))

  ;; Populate the frequency map
  (for ([char (string->list s)])
    (hash-update! freq-map char (lambda (v) (+ v 1)) 0))

  ;; Get the list of frequencies
  (define freqs (hash-values freq-map))

  ;; Sort frequencies in ascending order
  (define sorted-freqs (sort freqs <))

  ;; Calculate the number of distinct characters
  (define num-distinct-chars (length sorted-freqs))

  ;; If the number of distinct characters is already less than or equal to k,
  ;; no deletions are needed.
  (if (<= num-distinct-chars k)
      0
      ;; Otherwise, we need to delete characters corresponding to the smallest frequencies
      ;; until we have at most k distinct characters.
      (let* ([num-to-delete (- num-distinct-chars k)]
             [smallest-freqs (take sorted-freqs num-to-delete)])
        ;; The total deletions will be the sum of these smallest frequencies
        (apply + smallest-freqs))))