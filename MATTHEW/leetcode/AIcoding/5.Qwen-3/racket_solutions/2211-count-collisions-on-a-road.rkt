(define (count-collisions cars)
  (define (helper cars count)
    (cond [(null? cars) count]
          [(null? (cdr cars)) count]
          [else
           (let* ([a (car cars)]
                  [b (cadr cars)]
                  [new-count (if (or (= a b) (> a b)) (+ count 1) count)])
             (helper (cons a (cdr cars)) new-count))]))
  (helper cars 0))