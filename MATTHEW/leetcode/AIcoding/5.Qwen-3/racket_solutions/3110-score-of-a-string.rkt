(define (score-of-string s)
  (define (helper i acc)
    (if (>= i (string-length s))
        acc
        (helper (+ i 1) (+ acc (abs (- (char->integer (string-ref s i)) (char->integer (string-ref s (+ i 1)))))))))
  (helper 0 0))