(define (longest-ideal-string s k)
  (define n (string-length s))
  (define dp (make-vector 26 0))

  (for ([i (in-range n)])
    (define char-code (- (char->integer (string-ref s i)) (char->integer #\a)))
    (define current-max 1)
    (for ([j (in-range 26)])
      (when (<= (abs (- j char-code)) k)
        (set! current-max (max current-max (+ (vector-ref dp j) 1)))))
    (vector-set! dp char-code current-max))

  (apply max (vector->list dp)))