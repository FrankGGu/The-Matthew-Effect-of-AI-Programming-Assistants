(define (score-of-string s)
  (let* ((len (string-length s)))
    (if (< len 2)
        0
        (for/sum ([i (in-range (- len 1))])
          (abs (- (char->integer (string-ref s i))
                  (char->integer (string-ref s (+ i 1)))))))))