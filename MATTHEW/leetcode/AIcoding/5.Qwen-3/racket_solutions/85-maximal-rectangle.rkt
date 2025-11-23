#lang racket

(define (maximal-rectangle matrix)
  (define (largest-rectangle-in-histogram heights)
    (define (loop i stack max-area)
      (cond [(= i (length heights))
             max-area]
            [else
             (let ([h (list-ref heights i)])
               (if (or (null? stack) (<= h (list-ref (last stack) 1)))
                   (loop (+ i 1) (cons (cons i h) stack) max-area)
                   (let* ([top (last stack)]
                          [top-index (car top)]
                          [top-height (cdr top)]
                          [area (* top-height (- i top-index))])
                     (loop top-index (reverse (rest (reverse stack))) (max max-area area))))]))
    (loop 0 '() 0))

  (if (null? matrix)
      0
      (let ([rows (length matrix)]
            [cols (length (car matrix))])
        (let loop ([row 0] [heights (make-list cols 0)] [max-area 0])
          (if (= row rows)
              max-area
              (let ([new-heights
                     (map (lambda (i)
                            (if (= (list-ref (list-ref matrix row) i) #\1)
                                (+ (list-ref heights i) 1)
                                0))
                          (range cols))])
                (loop (+ row 1)
                      new-heights
                      (max max-area (largest-rectangle-in-histogram new-heights)))))))))