(define (capture-forts forts)
  (let loop ([forts forts] [max-capture 0] [last-non-zero #f])
    (cond
      [(null? forts) max-capture]
      [(zero? (car forts)) (loop (cdr forts) max-capture last-non-zero)]
      [(and (not #f last-non-zero) (not (equal? (car forts) last-non-zero)))
       (let ([capture (let loop2 ([forts (cdr forts)] [count 0])
                         (cond
                           [(null? forts) 0]
                           [(zero? (car forts)) (loop2 (cdr forts) (+ count 1))]
                           [(equal? (car forts) last-non-zero) count]
                           [else 0]))])
         (loop (cdr forts) (max max-capture capture) (car forts)))]
      [else (loop (cdr forts) max-capture (car forts))])))