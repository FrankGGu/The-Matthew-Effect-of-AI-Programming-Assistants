(define (minimum-pushes word)
  (define char-counts (make-hash))
  (for ([char (string->list word)])
    (hash-update! char-counts char (lambda (v) (+ v 1)) 0))

  (define sorted-frequencies
    (sort (hash-map char-counts (lambda (char count) count))
          (lambda (a b) (> a b))))

  (define total-pushes 0)
  (define current-multiplier 1)
  (define chars-on-current-multiplier 0)

  (for ([freq sorted-frequencies])
    (set! total-pushes (+ total-pushes (* freq current-multiplier)))
    (set! chars-on-current-multiplier (+ chars-on-current-multiplier 1))
    (when (= chars-on-current-multiplier 9)
      (set! current-multiplier (+ current-multiplier 1))
      (set! chars-on-current-multiplier 0)))

  total-pushes)