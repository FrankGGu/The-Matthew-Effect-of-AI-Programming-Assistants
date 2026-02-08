(define/contract (maximal-rectangle matrix)
  (-> (listof (listof char?)) exact-integer?)
  (if (null? matrix)
      0
      (let* ([rows (length matrix)]
             [cols (length (car matrix))]
             [heights (make-vector cols 0)]
             [max-area 0])
        (for ([row (in-range rows)])
          (for ([col (in-range cols)])
            (vector-set! heights col
              (if (char=? (list-ref (list-ref matrix row) col) #\1)
                  (+ (vector-ref heights col) 1)
                  0)))
          (set! max-area (max max-area (largest-rectangle-in-histogram heights))))
        max-area)))

(define (largest-rectangle-in-histogram heights)
  (let ([stack '()]
        [max-area 0]
        [n (vector-length heights)])
    (for ([i (in-range (+ n 1))])
      (let ([h (if (= i n) 0 (vector-ref heights i))])
        (while (and (not (null? stack)) (or (= i n) (< h (vector-ref heights (car stack)))))
          (let* ([top (car stack)]
                 [stack (cdr stack)]
                 [width (if (null? stack) i (- i (car stack) 1))])
            (set! max-area (max max-area (* (vector-ref heights top) width)))))
        (set! stack (cons i stack))))
    max-area))