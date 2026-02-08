(define (grid-illumination n lamps queries)
  (let* ([row (make-hash)]
         [col (make-hash)]
         [diag1 (make-hash)]
         [diag2 (make-hash)]
         [lamp-set (make-hash)])
    (for ([lamp lamps])
      (let ([x (car lamp)]
            [y (cadr lamp)])
        (hash-set! row x (add1 (hash-ref row x 0)))
        (hash-set! col y (add1 (hash-ref col y 0)))
        (hash-set! diag1 (+ x y) (add1 (hash-ref diag1 (+ x y) 0)))
        (hash-set! diag2 (- x y) (add1 (hash-ref diag2 (- x y) 0)))
        (hash-set! lamp-set (cons x y) #t)))
    (define (query x y)
      (if (or (> 0 (hash-ref row x 0))
              (> 0 (hash-ref col y 0))
              (> 0 (hash-ref diag1 (+ x y) 0))
              (> 0 (hash-ref diag2 (- x y) 0)))
          1 0))
    (define (turn-off x y)
      (for ([dx (list -1 0 1)])
        (for ([dy (list -1 0 1)])
          (let ([nx (+ x dx)]
                [ny (+ y dy)])
            (when (hash-ref lamp-set (cons nx ny) #f)
              (hash-remove! lamp-set (cons nx ny))
              (hash-set! row nx (sub1 (hash-ref row nx)))
              (hash-set! col ny (sub1 (hash-ref col ny)))
              (hash-set! diag1 (+ nx ny) (sub1 (hash-ref diag1 (+ nx ny))))
              (hash-set! diag2 (- nx ny) (sub1 (hash-ref diag2 (- nx ny))))))))
    (define res '())
    (for ([q queries])
      (let ([x (car q)]
            [y (cadr q)])
        (set! res (cons (query x y) res))
        (turn-off x y)))
    (reverse res)))