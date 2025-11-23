(define (min-set-size arr)
  (define n (length arr))
  (define half-n (/ n 2))

  ;; Count frequencies of each number
  (define freq-map (make-hash))
  (for-each (lambda (x)
              (hash-update! freq-map x (lambda (v) (+ v 1)) 0))
            arr)

  ;; Get frequencies as a list and sort in descending order
  (define freqs (sort (hash-values freq-map) >))

  ;; Iterate through sorted frequencies, accumulating removed elements
  ;; until half the original array size is reached or exceeded.
  (define removed-count 0)
  (define set-size 0)

  (for-each (lambda (f)
              (when (< removed-count half-n)
                (set! removed-count (+ removed-count f))
                (set! set-size (+ set-size 1))))
            freqs)
  set-size)