(define (count-collisions directions)
  (let loop ([i 0]
             [collisions 0]
             [stack '()])
    (if (>= i (string-length directions))
        collisions
        (let ([current (string-ref directions i)])
          (case current
            [(#\L)
             (if (null? stack)
                 (loop (+ i 1) collisions stack)
                 (let ([top (car stack)])
                   (case top
                     [(#\R)
                      (loop (+ i 1) (+ collisions 2) (cons #\S (cdr stack)))]
                     [(#\S)
                      (loop (+ i 1) (+ collisions 1) (cons #\S (cdr stack)))]
                     [else (loop (+ i 1) collisions stack)])))]
            [(#\R)
             (loop (+ i 1) collisions (cons #\R stack))]
            [(#\S)
             (loop (+ i 1) collisions (cons #\S stack))])))))