#lang racket

(define (transpose matrix)
  (if (empty? matrix)
      '()
      (let* ((num-rows (length matrix))
             (num-cols (length (car matrix))))

        (define (get-element row col)
          (list-ref (list-ref matrix row) col))

        (for/list ([col-idx (in-range num-cols)])
          (for/list ([row-idx (in-range num-rows)])
            (get-element row-idx col-idx))))))