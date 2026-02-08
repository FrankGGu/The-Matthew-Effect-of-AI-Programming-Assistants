(define (largest-odd-number s)
  (let loop ([i (- (string-length s) 1)])
    (cond
      [(< i 0) ""]
      [(odd? (string->number (substring s i (+ i 1)))) (substring s 0 (+ i 1))]
      [else (loop (- i 1))])))