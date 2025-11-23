(define (count-pairs nums target)
  (define (helper i j count)
    (cond [(>= i (length nums)) count]
          [(>= j (length nums)) (helper (+ i 1) 0 count)]
          [else (if (< (+ (list-ref nums i) (list-ref nums j)) target)
                    (helper i (+ j 1) (+ count 1))
                    (helper i (+ j 1) count))]))
  (helper 0 1 0))