(define (remove-trailing-zeros s)
  (let loop ([i (- (string-length s) 1)])
    (cond
      [(< i 0) ""]
      [(not (equal? (string-ref s i) #\0)) (substring s 0 (+ i 1))]
      [else (loop (- i 1))])))