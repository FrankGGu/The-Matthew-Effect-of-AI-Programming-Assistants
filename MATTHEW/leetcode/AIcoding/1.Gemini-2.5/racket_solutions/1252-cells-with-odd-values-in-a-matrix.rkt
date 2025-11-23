(define (odd-cells m n indices)
  (let* ([row-counts (make-vector m 0)]
         [col-counts (make-vector n 0)])

    (for-each (lambda (idx-pair)
                (let ([r (car idx-pair)]
                      [c (cadr idx-pair)])
                  (vector-set! row-counts r (+ (vector-ref row-counts r) 1))
                  (vector-set! col-counts c (+ (vector-ref col-counts c) 1))))
              indices)

    (let ([num-odd-rows 0]
          [num-odd-cols 0])

      (for ([i (in-range m)])
        (when (odd? (vector-ref row-counts i))
          (set! num-odd-rows (+ num-odd-rows 1))))

      (for ([j (in-range n)])
        (when (odd? (vector-ref col-counts j))
          (set! num-odd-cols (+ num-odd-cols 1))))

      (let ([num-even-rows (- m num-odd-rows)]
            [num-even-cols (- n num-odd-cols)])
        (+ (* num-odd-rows num-even-cols)
           (* num-even-rows num-odd-cols))))))