(define (min-additions s)
  (define (helper s open)
    (cond
      [(string-empty? s) open]
      [(char=? (string-ref s 0) #\() (helper (substring s 1) (+ open 1))]
      [(char=? (string-ref s 0) #\)) (if (> open 0) (helper (substring s 1) (- open 1)) (+ open 1))]
      [else (helper (substring s 1) open)]))
  (helper s 0))