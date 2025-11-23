(define (min-operations boxes)
  (let loop ([boxes boxes] [left 0] [right 0] [res '()] [i 0])
    (if (null? boxes)
        (reverse res)
        (let* ([current (car boxes)]
               [new-left (+ left current)]
               [new-right (+ right (if (> i 0) (list-ref res (- i 1)) 0))]
               [new-res (cons (- new-right new-left) res)])
          (loop (cdr boxes) new-left new-right new-res (+ i 1))))))