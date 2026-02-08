(define (mirror-score s)
  (let ([n (string-length s)]
        [score 0])
    (for ([i (in-range 0 (quotient n 2))])
      (when (char=? (string-ref s i) (string-ref s (- (- n 1) i)))
        (set! score (+ score 1))))
    score))