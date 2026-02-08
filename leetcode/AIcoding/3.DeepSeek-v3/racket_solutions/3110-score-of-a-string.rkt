(define (score-of-string s)
  (let loop ([i 0] [sum 0])
    (if (>= i (sub1 (string-length s)))
        sum
        (loop (add1 i) (+ sum (abs (- (char->integer (string-ref s i)) 
                                     (char->integer (string-ref s (add1 i)))))))))