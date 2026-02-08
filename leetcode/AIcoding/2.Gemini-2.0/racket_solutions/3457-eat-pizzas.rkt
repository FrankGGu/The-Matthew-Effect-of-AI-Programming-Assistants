(define (eat-pizzas pizzas)
  (let loop ([pizzas pizzas] [eaten 0])
    (cond
      [(null? pizzas) eaten]
      [(<= (car pizzas) eaten) (loop (cdr pizzas) eaten)]
      [else (loop (cdr pizzas) (+ eaten 1))])))