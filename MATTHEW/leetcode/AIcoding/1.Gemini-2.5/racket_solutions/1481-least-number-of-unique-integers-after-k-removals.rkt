#lang racket

(define (find-least-num-of-unique-ints arr k)
  (define freq-map (make-hash))

  ;; Populate frequency map
  (for-each (lambda (x)
              (hash-update! freq-map x (lambda (v) (+ v 1)) 0))
            arr)

  ;; Get frequencies and sort them in ascending order
  (define frequencies (sort (hash-values freq-map) <))

  (define current-k k)
  (define unique-count (length frequencies))

  ;; Iterate through sorted frequencies and remove elements
  (for-each (lambda (freq)
              (when (> current-k 0) ; Only process if k removals are still possible
                (if (>= current-k freq)
                    (begin
                      (set! current-k (- current-k freq))
                      (set! unique-count (- unique-count 1)))
                    ;; If current-k < freq, we can't remove all occurrences of this number
                    ;; and thus can't reduce the unique count further by removing this specific number.
                    ;; We also can't remove any subsequent numbers as they have equal or higher frequencies.
                    (void)))) ; Do nothing if k is exhausted or insufficient for current freq
            frequencies)

  unique-count)