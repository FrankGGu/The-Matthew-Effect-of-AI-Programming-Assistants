(define (minimizeArrayValue nums)
  (let loop ((i (sub1 (length nums))) (max-value (vector-ref nums 0)))
    (if (< i 0)
        max-value
        (let ((current (max max-value (vector-ref nums i))))
          (loop (sub1 i) current)))))