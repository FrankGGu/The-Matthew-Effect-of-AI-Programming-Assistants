(define (maximal-rectangle matrix)
  (if (null? matrix)
      0
      (let* ([rows (length matrix)]
             [cols (length (car matrix))]
             [heights (make-vector cols 0)]
             [max-area 0])
        (for ([i (in-range rows)])
          (for ([j (in-range cols)])
            (if (equal? (list-ref (list-ref matrix i) j) #\1)
                (vector-set! heights j (+ (vector-ref heights j) 1))
                (vector-set! heights j 0)))
          (set! max-area (max max-area (largest-rectangle-area heights))))
        max-area)))

(define (largest-rectangle-area heights)
  (let* ([n (vector-length heights)]
         [stack '()]
         [max-area 0])
    (for ([i (in-range (add1 n))])
      (let ([current-height (if (= i n) 0 (vector-ref heights i))])
        (while (and (not (null? stack))
                    (>= (vector-ref heights (car stack)) current-height))
          (let* ([top (car stack)]
                 [height (vector-ref heights top)]
                 [width (if (null? (cdr stack)) i (- i (car (cdr stack)) 1))]
                 [area (* height width)])
            (set! max-area (max max-area area))
            (set! stack (cdr stack))))
        (set! stack (cons i stack))))
    max-area))