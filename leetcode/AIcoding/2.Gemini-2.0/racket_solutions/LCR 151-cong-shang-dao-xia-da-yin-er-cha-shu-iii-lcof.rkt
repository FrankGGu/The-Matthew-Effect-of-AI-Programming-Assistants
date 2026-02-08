(define (record-lights lights)
  (let loop ([lights lights] [result '()])
    (cond
      [(null? lights) (reverse result)]
      [(null? (cdr lights)) (cons (car lights) result)]
      [else
       (let ([a (car lights)] [b (cadr lights)])
         (cond
           [(= a b) (loop (cddr lights) (cons a result))]
           [else (loop (cdr lights) (cons a result))]))])))