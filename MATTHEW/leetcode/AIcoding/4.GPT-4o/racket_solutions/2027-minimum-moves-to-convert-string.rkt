(define (minimumMoves s)
  (define (helper s idx)
    (if (>= idx (string-length s))
        0
        (if (string-ref s idx) #\X)
            (+ 1 (helper s (+ idx 3)))
            (helper s (+ idx 1)))))
  (helper s 0))