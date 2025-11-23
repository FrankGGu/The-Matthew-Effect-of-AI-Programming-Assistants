(define (sumZero n)
  (if (even? n)
      (append (range (- (/ n 2)) 1) (range (- (/ n 2)) 0))
      (cons 0 (append (range (- (/ n 2)) 1) (range (- (/ n 2)) 0)))))

(define (range start end)
  (if (>= start end)
      '()
      (cons start (range (+ start 1) end))))