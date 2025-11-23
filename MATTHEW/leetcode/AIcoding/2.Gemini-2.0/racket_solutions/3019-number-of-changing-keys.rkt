(define (number-of-changing-keys s)
  (let loop ([chars (string->list s)]
             [prev #f]
             [count 0])
    (cond
      [(empty? chars) count]
      [else
       (let ([curr (car chars)])
         (if (and prev (not (equal? (char-downcase curr) (char-downcase prev))))
             (loop (cdr chars) curr (+ count 1))
             (loop (cdr chars) curr count)))])))