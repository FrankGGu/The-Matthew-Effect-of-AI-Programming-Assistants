(define (is-valid-start start obstacles width height)
  (let loop ([q (list start)]
             [visited (make-hash)])
    (if (null? q)
        #f
        (let* ([curr (car q)]
               [x (car curr)]
               [y (cadr curr)])
          (cond
            [(or (< x 0) (>= x width) (< y 0) (>= y height) (hash-has-key? visited curr))
             (loop (cdr q) visited)]
            [(member (list x y) obstacles)
             (loop (cdr q) visited)]
            [(= x (sub1 width))
             #t]
            [else
             (hash-set! visited curr #t)
             (loop (append (cdr q) (list (list (add1 x) y) (list x (add1 y)) (list (sub1 x) y) (list x (sub1 y)))) visited)])))))

(define (bicycle-trick-arena obstacles width height start)
  (if (is-valid-start start obstacles width height)
      "YES"
      "NO"))