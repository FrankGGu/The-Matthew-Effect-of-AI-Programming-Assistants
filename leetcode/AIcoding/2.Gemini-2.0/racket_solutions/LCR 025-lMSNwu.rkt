(define (add-two-numbers l1 l2)
  (define (list->number lst)
    (foldl (lambda (x acc) (+ (* 10 acc) x)) 0 lst))

  (define (number->list n)
    (cond [(zero? n) '(0)]
          [else (reverse
                 (let loop ([n n] [acc '()])
                   (if (zero? n)
                       acc
                       (loop (quotient n 10) (cons (remainder n 10) acc)))))]))

  (number->list (+ (list->number l1) (list->number l2))))