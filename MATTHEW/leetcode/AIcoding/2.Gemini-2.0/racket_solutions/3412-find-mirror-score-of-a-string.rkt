(define (mirror-score s)
  (let loop ([i 0] [j (- (string-length s) 1)] [score 0])
    (cond
      [(>= i j) score]
      [(equal? (string-ref s i) (string-ref s j))
       (loop (+ i 1) (- j 1) (+ score 2))]
      [else score])))