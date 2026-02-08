(define/contract (maximal-rectangle matrix)
  (-> (listof (listof char?)) exact-integer?)
  (if (null? matrix)
      0
      (let* ([rows (length matrix)]
             [cols (length (car matrix))]
             [heights (make-vector cols 0)]
             [max-area 0])
        (for ([row matrix] [i (in-range rows)])
          (for ([c row] [j (in-range cols)])
            (vector-set! heights j
                         (if (char=? c #\1)
                             (+ (vector-ref heights j) 1)
                             0)))
          (set! max-area (max max-area (largest-rectangle-in-histogram (vector->list heights)))))
        max-area)))

(define (largest-rectangle-in-histogram heights)
  (let ([stack '()]
        [max-area 0]
        [heights (append heights '(0))])
    (for ([h heights] [i (in-naturals)])
    (for ([h heights] [i (in-naturals)])
      (let loop ()
        (when (and (not (null? stack))
                   (< (car (car stack)) h))
        (let* ([top (car stack)]
               [stack (cdr stack)]
               [width (if (null? stack) i (- i (car (car stack)) 1))]
               [area (* (car top) width)])
          (set! max-area (max max-area area))
          (loop))))
    (set! stack (cons (cons h i) stack)))
    max-area))