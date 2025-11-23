(define (repeated-string-match a b)
  (define (contains? str substr)
    (and (>= (string-length str) (string-length substr))
         (not (equal? (string-index str substr) #f))))

  (let loop ([i 1] [s a])
    (cond
      [(contains? s b) i]
      [(> i (+ (quotient (string-length b) (string-length a)) 2)) -1]
      [else (loop (+ i 1) (string-append s a))])))