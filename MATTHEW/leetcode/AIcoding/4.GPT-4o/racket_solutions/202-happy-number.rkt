(define (is-happy n)
  (define (next num)
    (foldl (lambda (digit acc) (+ acc (sqr digit))) 0 (map (lambda (x) (modulo x 10)) (list->vector (number->string num)))))

  (define (helper num seen)
    (cond
      [(= num 1) #t]
      [(set-member? seen num) #f]
      [else (helper (next num) (set-add seen num))]))

  (helper n (set-empty))
)