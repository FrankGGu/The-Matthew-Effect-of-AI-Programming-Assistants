(define (maxBuilding n restrictions)
  (define m (length restrictions))
  (define restrictions (sort restrictions (λ (a b) (< (car a) (car b)))))
  (set! restrictions (cons (list 0 0) (append restrictions (list (list n n)))))
  (define h (length restrictions))
  (for/fold ([max-height 0]) ([i (in-range h)])
    (let* ([x1 (car (list-ref restrictions i))]
           [h1 (cadr (list-ref restrictions i))]
           [x2 (car (list-ref restrictions (add1 i)))]
           [h2 (cadr (list-ref restrictions (add1 i)))]
           [height (max (/ (* (- x2 x1) (+ h1 h2)) 2) (max h1 h2))])
           [new-max (max max-height height)])
      new-max)))