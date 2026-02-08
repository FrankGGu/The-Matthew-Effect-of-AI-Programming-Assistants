(define (min-deletions s)
  ;; 1. Count character frequencies
  (define char-counts (make-hash))
  (for ([c (string->list s)])
    (hash-update! char-counts c add1 0))

  ;; 2. Extract non-zero frequencies and sort them in descending order
  (define frequencies
    (sort (hash-values char-counts) >))

  ;; 3. Iterate through sorted frequencies and adjust
  (define used-frequencies (make-hash-set))
  (define operations 0)

  (for ([freq frequencies])
    (let loop ([current-freq freq])
      (when (> current-freq 0)
        (if (hash-set-contains? used-frequencies current-freq)
            ;; Frequency is already used, decrement and try again
            (begin
              (set! operations (add1 operations))
              (loop (sub1 current-freq)))
            ;; Frequency is unique, add it to used-frequencies
            (hash-set-add! used-frequencies current-freq)))))
  operations)