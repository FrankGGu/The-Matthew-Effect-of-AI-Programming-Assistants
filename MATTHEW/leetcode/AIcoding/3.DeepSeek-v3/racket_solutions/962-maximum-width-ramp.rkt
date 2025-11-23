(define (max-width-ramp nums)
  (let* ([stack '()]
         [n (length nums)]
         [nums-list (list->vector nums)]
         [stack (let loop ([i 0] [stack stack])
                  (if (= i n)
                      stack
                      (if (or (null? stack) (< (vector-ref nums-list (car stack)) (vector-ref nums-list i)))
                          (loop (+ i 1) (cons i stack))
                          (loop (+ i 1) stack))))]
         [max-width 0])
    (let loop ([j (- n 1)])
      (if (< j 0)
          max-width
          (let ([current (vector-ref nums-list j)])
              (let inner-loop ([stack stack])
                (if (and (not (null? stack)) (<= (vector-ref nums-list (car stack)) current))
                    (begin
                      (set! max-width (max max-width (- j (car stack))))
                      (inner-loop (cdr stack)))
                    (loop (- j 1))))))))