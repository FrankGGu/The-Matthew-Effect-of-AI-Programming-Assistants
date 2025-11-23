(define (powerful-integers x y bound)
  (define (generate-powers a limit)
    (let loop ([n 1] [powers '()])
      (cond
        [(> n limit) (reverse powers)]
        [(= a 1) (list 1)]
        [else (loop (* n a) (cons n powers))])))

  (define powers-x (generate-powers x bound))
  (define powers-y (generate-powers y bound))

  (define result (set))

  (for ([px (in-list powers-x)])
    (for ([py (in-list powers-y)])
      (let ([sum (+ px py)])
        (when (<= sum bound)
          (set-add! result sum)))))

  (set->list result))