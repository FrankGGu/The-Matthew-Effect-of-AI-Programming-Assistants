(define (are-numbers-equal s)
  (let loop ([i 0] [sum 0])
    (cond
      [(>= i (string-length s)) (zero? (remainder sum 3))]
      [else (loop (+ i 1) (+ sum (- (char->integer (string-ref s i)) (char->integer #\0))))])))