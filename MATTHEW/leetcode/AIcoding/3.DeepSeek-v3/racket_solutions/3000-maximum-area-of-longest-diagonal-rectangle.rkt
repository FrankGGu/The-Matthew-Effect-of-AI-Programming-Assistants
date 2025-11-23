(define/contract (area-of-max-diagonal rects)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define (diagonal l w) (sqrt (+ (* l l) (* w w))))
  (define (area l w) (* l w))
  (let loop ([rects rects]
             [max-diag 0]
             [max-area 0])
    (if (null? rects)
        max-area
        (let* ([rect (car rects)]
               [l (car rect)]
               [w (cadr rect)]
               [d (diagonal l w)])
          (cond
            [(> d max-diag) (loop (cdr rects) d (area l w))]
            [(= d max-diag) (loop (cdr rects) max-diag (max max-area (area l w)))]
            [else (loop (cdr rects) max-diag max-area)])))))