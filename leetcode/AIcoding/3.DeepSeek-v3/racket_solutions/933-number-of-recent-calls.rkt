(define recent-calls%
  (class object%
    (super-new)
    (init-field)
    (define calls '())

    (define/public (ping t)
      (set! calls (cons t calls))
      (let loop ([lst calls] [count 0])
        (cond
          [(null? lst) count]
          [(<= (- t (car lst)) 3000) (loop (cdr lst) (add1 count))]
          [else count])))))

(define obj (new recent-calls%))