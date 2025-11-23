(define (max-consecutive-floors bottom top special)
  (let* ([sorted-special (sort special <)]
         [points (cons (sub1 bottom) (append sorted-special (list (add1 top))))])
    (let loop ([current-points points]
               [max-gap 0])
      (if (null? (cdr current-points))
          max-gap
          (let* ([p1 (car current-points)]
                 [p2 (cadr current-points)]
                 [gap (- p2 p1 1)])
            (loop (cdr current-points)
                  (max max-gap gap)))))))